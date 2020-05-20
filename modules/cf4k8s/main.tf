resource "kubernetes_namespace" "cf" {
  metadata {
    name = "cf-system"
  }
}

resource "random_password" "gen" {
  length = 24
  special = false
}

data "template_file" "cf4k8s_config" {
  template = file("${path.module}/templates/config.yml")

  vars = {
    system_domain = local.system_domain
    app_domain = local.app_domain

    cf_admin_password = random_password.gen.result
    cf_blobstore_secret_key = random_password.gen.result
    cf_db_admin_password = random_password.gen.result
    ccdb_password = random_password.gen.result
    uaa_db_password = random_password.gen.result
    uaa_admin_client_secret = random_password.gen.result
    encryption_key_passphrase = random_password.gen.result

    # @see https://github.com/hashicorp/terraform/issues/16775#issuecomment-349170517
    internal_tls_cert_unencoded        = "${jsonencode(tls_locally_signed_cert.cf.cert_pem)}"
    internal_tls_key_unencoded         = "${jsonencode(tls_private_key.cf.private_key_pem)}"

    internal_tls_cert        = base64encode(tls_locally_signed_cert.cf.cert_pem)
    internal_tls_key         = base64encode(tls_private_key.cf.private_key_pem)
    internal_tls_ca_cert     = base64encode(tls_self_signed_cert.acme_ca.cert_pem)

    registry_domain     = var.registry_domain
    registry_repository = var.registry_repository
    registry_username   = var.registry_username
    registry_password   = var.registry_password
  }
}

resource "local_file" "cf4k8s_config_rendered" {
  content     = data.template_file.cf4k8s_config.rendered
  filename = "${path.module}/${var.ytt_lib_dir}/cf4k8s/vendor/config-rendered.yml"
}

data "template_file" "cf4k8s_cert" {
  template = file("${path.module}/templates/cert.yml")

  vars = {
    system_domain = local.system_domain
    namespace     = kubernetes_namespace.cf.metadata[0].name
  }
}

resource "local_file" "cf4k8s_cert_rendered" {
  content     = data.template_file.cf4k8s_cert.rendered
  filename = "${path.module}/${var.ytt_lib_dir}/cf4k8s/vendor/cert-rendered.yml"
}

resource "k14s_kapp" "cf4k8s_cert" {
  app = "cf4k8s-cert"

  namespace = "default"

  config_yaml = data.template_file.cf4k8s_cert.rendered
}

data "k14s_ytt" "cf4k8s_ytt" {
  files = [
    "${path.module}/${var.ytt_lib_dir}/cf4k8s/vendor/github.com/cloudfoundry/cf-for-k8s/config",
    "${path.module}/${var.ytt_lib_dir}/cf4k8s/vendor/github.com/cloudfoundry/cf-for-k8s/config-optional"
  ]

  debug_logs = true

  config_yaml = data.template_file.cf4k8s_config.rendered

  depends_on = [
    local_file.cf4k8s_config_rendered
  ]
}

resource "local_file" "cf4k8s_ytt" {
  content = data.k14s_ytt.cf4k8s_ytt.result
  filename = "${path.module}/${var.ytt_lib_dir}/cf4k8s/vendor/config-ytt.yml"
}

resource "k14s_kapp" "cf4k8s" {
  app = "cf"
  namespace = "default"

  config_yaml = data.k14s_ytt.cf4k8s_ytt.result

  debug_logs = true

  deploy {
    raw_options = ["--dangerous-allow-empty-list-of-resources=true"]
  }

  depends_on = [
    k14s_kapp.cf4k8s_cert,
    local_file.cf4k8s_ytt
  ]

}