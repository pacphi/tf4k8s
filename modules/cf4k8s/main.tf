resource "kubernetes_namespace" "cf" {
  metadata {
    name = "cf-system"
  }
}

resource "random_password" "gen" {
  length = 24
  special = false
}

data "template_file" "values" {
  template = file("${path.module}/templates/values.yml")

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

    internal_tls_cert_unencoded        = tls_locally_signed_cert.cf.cert_pem
    internal_tls_key_unencoded         = tls_private_key.cf.private_key_pem

    internal_tls_cert        = base64encode(tls_locally_signed_cert.cf.cert_pem)
    internal_tls_key         = base64encode(tls_private_key.cf.private_key_pem)
    internal_tls_ca_cert     = base64encode(tls_self_signed_cert.acme_ca.cert_pem)

    registry_domain     = var.registry_domain
    registry_repository = var.registry_repository
    registry_username   = var.registry_username
    registry_password   = var.registry_password
  }
}

data "template_file" "cf4k8s_cert" {
  template = file("${path.module}/templates/cert.yml")

  vars = {
    system_domain = local.system_domain
    namespace     = kubernetes_namespace.cf.metadata[0].name
  }

}

resource "k14s_kapp" "cf4k8s_cert" {
  app = "cf4k8s-cert"

  namespace = "default"

  config_yaml = data.template_file.cf4k8s_cert.rendered

  deploy {
    raw_options = ["--dangerous-allow-empty-list-of-resources=true"]
  }
}

data "k14s_ytt" "cf4k8s" {
  files = [
    "${local.ytt_lib_dir}/cf4k8s/vendor/github.com/cloudfoundry/cf-for-k8s/config",
    "${local.ytt_lib_dir}/cf4k8s/vendor/github.com/cloudfoundry/cf-for-k8s/config-optional",
  ]

  config_yaml = data.template_file.values.rendered
}

resource "k14s_kapp" "cf4k8s" {
  app = "cf"
  namespace = "default"

  config_yaml = data.k14s_ytt.cf4k8s.result

  deploy {
    raw_options = ["--dangerous-allow-empty-list-of-resources=true"]
  }

  depends_on = [k14s_kapp.cf4k8s_cert]
}