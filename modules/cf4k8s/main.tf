resource "kubernetes_namespace" "cf" {
  metadata {
    name = "cf-system"
  }
}

resource "random_password" "gen" {
  length = 24
  special = false
}

data "local_file" "cf4k8s_config" {
  filename = local.cf4k8s_config
}

data "local_file" "certs_vars" {
  filename = "${path.module}/certs.auto.tfvars"
}

data "template_file" "cf4k8s_config_additions" {
  template = file("${path.module}/templates/cf-values-additions.yml")

  vars = {
    system_domain = local.system_domain
    app_domain = local.app_domain

    system_fullchain_certificate = element(split(" = ", element(split("\n", data.local_file.certs_vars.content), 0)), 1)
    system_private_key = element(split(" = ", element(split("\n", data.local_file.certs_vars.content), 1)), 1)
    workloads_fullchain_certificate = element(split(" = ", element(split("\n", data.local_file.certs_vars.content), 2)), 1)
    workloads_private_key = element(split(" = ", element(split("\n", data.local_file.certs_vars.content), 3)), 1)

    cf_admin_password = random_password.gen.result

    registry_domain     = var.registry_domain
    repository_prefix   = var.repository_prefix
    registry_username   = var.registry_username
    registry_password   = var.registry_password

    https_only = var.https_only
    remove_resource_requirements = var.remove_resource_requirements
    add_metrics_server_components = var.add_metrics_server_components
    enable_load_balancer = var.enable_load_balancer
    use_external_dns_for_wildcard = var.use_external_dns_for_wildcard
    enable_automount_service_account_token = var.enable_automount_service_account_token
    metrics_server_prefer_internal_kubelet_address = var.metrics_server_prefer_internal_kubelet_address
    use_first_party_jwt_tokens = var.use_first_party_jwt_tokens
  }
}

resource "local_file" "cf4k8s_joined_config" {
  content  = join("\n", [ data.local_file.cf4k8s_config.content, data.template_file.cf4k8s_config_additions.rendered ])
  filename = "${local.tmp_dir}/cf-values-joined.yml"
}

data "template_file" "cf4k8s_cert" {
  template = file("${path.module}/templates/cert.yml")

  vars = {
    system_domain = local.system_domain
    app_domain = local.app_domain
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

  debug_logs = true

  depends_on = [
    local_file.cf4k8s_cert_rendered
  ]
}

data "k14s_ytt" "cf4k8s_ytt" {
  files = [
    "${path.module}/${var.ytt_lib_dir}/cf4k8s/vendor/github.com/cloudfoundry/cf-for-k8s/config",
    local_file.cf4k8s_joined_config.filename
  ]

  debug_logs = true
}

resource "local_file" "cf4k8s_rendered" {
  content = data.k14s_ytt.cf4k8s_ytt.result
  filename = "${local.tmp_dir}/cf-for-k8s-rendered.yml"
}

resource "k14s_kapp" "cf4k8s" {
  app = "cf"
  namespace = "default"

  config_yaml = data.k14s_ytt.cf4k8s_ytt.result

  debug_logs = true

  depends_on = [
    k14s_kapp.cf4k8s_cert,
    local_file.cf4k8s_rendered
  ]
}