resource "kubernetes_namespace" "tsmgr" {
  metadata {
    name = "tsmgr"
  }
}

data "template_file" "tsmgr_cert" {
  template = file("${path.module}/templates/cert.tpl")

  vars = {
    tsmgr_domain = var.domain
    daemon_domain = "daemon.${var.domain}"
    broker_domain = "broker.${var.domain}"
    namespace     = kubernetes_namespace.tsmgr.metadata[0].name
  }
}

resource "k14s_kapp" "tsmgr_cert" {
  app = "tsmgr-cert"

  namespace = "default"

  config_yaml = data.template_file.tsmgr_cert.rendered
}

resource "random_password" "broker_password" {
  length = 16
  special = false
}

resource "random_password" "daemon_password" {
  length = 16
  special = false
}

resource "random_password" "chartmuseum_password" {
  length = 16
  special = false
}

data "template_file" "tsmgr_config" {
  template = file("${path.module}/templates/${var.ingress}/values.tpl")

  vars = {
    tsmgr_domain  = var.domain
    daemon_domain = "daemon.${var.domain}"
    broker_domain = "broker.${var.domain}"
    tsmgr_images_registry = "${var.registry_domain}/${var.tsmgr_images_prefix}"
    si_images_registry = "${var.registry_domain}/${var.si_images_prefix}"
    registry_username = var.registry_username
    registry_password = var.registry_password
    broker_password = random_password.broker_password.result
    daemon_password = random_password.daemon_password.result
    chartmuseum_password = random_password.chartmuseum_password.result
    s3_bucket_name = var.s3_bucket_name
    s3_endpoint = var.s3_endpoint
    s3_access_key = var.s3_access_key
    s3_secret_key = var.s3_secret_key
    cf_api_endpoint = var.cf_api_endpoint
    cf_admin_username = var.cf_admin_username
    cf_admin_password = var.cf_admin_password
  }
}

resource "helm_release" "tsmgr" {
  depends_on = [k14s_kapp.tsmgr_cert]

  name       = "tsmgr"
  namespace  = kubernetes_namespace.tsmgr.metadata[0].name
  chart      = var.chart_path

  values = [data.template_file.tsmgr_config.rendered]

  timeout    = 400
}
