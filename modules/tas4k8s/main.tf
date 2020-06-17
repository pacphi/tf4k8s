resource "kubernetes_namespace" "tas" {
  metadata {
    name = "cf-system"
  }
}

resource "random_password" "gen" {
  length = 24
  special = false
}

data "template_file" "cf_values" {
  template = file("${path.module}/templates/cf-values.yml")

  vars = {
    cf_admin_password = random_password.gen.result
  }
}

resource "local_file" "cf_values_rendered" {
  content     = data.template_file.cf_values.rendered
  filename = "${path.module}/${var.ytt_lib_dir}/tas4k8s/vendor/configuration-values/cf-values.yml"
}

data "template_file" "app_registry_values" {
  template = file("${path.module}/templates/app-registry-values.yml")

  vars = {
    registry_domain     = var.registry_domain
    registry_repository = var.registry_repository
    registry_username   = var.registry_username
    registry_password   = var.registry_password
  }
}
resource "local_file" "app_registry_values_rendered" {
  content     = data.template_file.app_registry_values.rendered
  filename = "${path.module}/${var.ytt_lib_dir}/tas4k8s/vendor/configuration-values/app-registry-values.yml"
}

data "template_file" "system_registry_values" {
  template = file("${path.module}/templates/system-registry-values.yml")

  vars = {
    pivnet_username     = var.pivnet_username
    pivnet_password     = var.pivnet_password
  }
}

resource "local_file" "system_registry_values_rendered" {
  content     = data.template_file.system_registry_values.rendered
  filename = "${path.module}/${var.ytt_lib_dir}/tas4k8s/vendor/configuration-values/system-registry-values.yml"
}

resource "local_file" "load_balancer_values_rendered" {
  content     = file("${path.module}/templates/load-balancer-values.yml")
  filename = "${path.module}/${var.ytt_lib_dir}/tas4k8s/vendor/configuration-values/load-balancer-values.yml"
}

data "template_file" "tas4k8s_cert" {
  template = file("${path.module}/templates/cert.yml")

  vars = {
    system_domain = local.system_domain
    namespace     = kubernetes_namespace.tas.metadata[0].name
  }
}

resource "local_file" "tas4k8s_cert_rendered" {
  content     = data.template_file.tas4k8s_cert.rendered
  filename = "${path.module}/${var.ytt_lib_dir}/tas4k8s/vendor/cert-rendered.yml"
}

resource "k14s_kapp" "tas4k8s_cert" {
  app = "tas4k8s-cert"

  namespace = "default"

  config_yaml = data.template_file.tas4k8s_cert.rendered

  debug_logs = true

  depends_on = [
    local_file.tas4k8s_cert_rendered
  ]
}

data "k14s_ytt" "tas4k8s_ytt" {
  files = [
    "${path.module}/${var.ytt_lib_dir}/tas4k8s/vendor/config",
    "${path.module}/${var.ytt_lib_dir}/tas4k8s/vendor/configuration-values",
    "${path.module}/${var.ytt_lib_dir}/tas4k8s/vendor/config-optional/use-external-dns-for-wildcard.yml"
  ]

  debug_logs = true

  depends_on = [
    local_file.cf_values_rendered,
    local_file.app_registry_values_rendered,
    local_file.system_registry_values_rendered,
    local_file.load_balancer_values_rendered
  ]
}

data "k14s_kbld" "tas4k8s_config" {
  config_yaml = data.k14s_ytt.tas4k8s_ytt.result

  debug_logs = true
}

resource "local_file" "tas4k8s_config" {
  content     = data.k14s_kbld.tas4k8s_config.result
  filename = "${path.module}/${var.ytt_lib_dir}/tas4k8s/vendor/tas.yml"
}

resource "k14s_kapp" "tas4k8s" {
  app = "tas"
  namespace = "default"

  config_yaml = local_file.tas4k8s_config.content

  debug_logs = true

  depends_on = [
    k14s_kapp.tas4k8s_cert
  ]
}