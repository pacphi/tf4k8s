resource "kubernetes_namespace" "tas" {
  metadata {
    name = "cf-system"
  }
}

resource "kubernetes_namespace" "postgres" {
  metadata {
    name = "postgres-dbms"
  }
}

resource "random_password" "cf" {
  length = 24
  special = false
}

resource "random_password" "postgres" {
  length = 16
  special = false
}

data "local_file" "certs_vars" {
  filename = "${path.module}/certs.auto.tfvars"
}

data "template_file" "baseline_values" {
  template = file("${path.module}/templates/values.yml")

  vars = {
    system_domain = local.system_domain
    app_domain = local.app_domain

    cf_admin_password = random_password.cf.result
    
    postgres_password = random_password.postgres.result
    postgres_instance_name = local.postgres_instance_name
    postgres_instance_namespace = kubernetes_namespace.postgres.metadata[0].name
    
    system_fullchain_certificate = element(split(" = ", element(split("\n", data.local_file.certs_vars.content), 0)), 1)
    system_private_key = element(split(" = ", element(split("\n", data.local_file.certs_vars.content), 1)), 1)
    workloads_fullchain_certificate = element(split(" = ", element(split("\n", data.local_file.certs_vars.content), 2)), 1)
    workloads_private_key = element(split(" = ", element(split("\n", data.local_file.certs_vars.content), 3)), 1)

    registry_domain     = var.registry_domain
    repository_prefix   = var.repository_prefix
    registry_username   = var.registry_username
    registry_password   = var.registry_password

    pivnet_registry_hostname = var.pivnet_registry_hostname
    pivnet_username          = var.pivnet_username
    pivnet_password          = var.pivnet_password

    remove_resource_requirements = var.remove_resource_requirements
    add_metrics_server_components = var.add_metrics_server_components
    enable_load_balancer = var.enable_load_balancer
    use_external_dns_for_wildcard = var.use_external_dns_for_wildcard
    enable_automount_service_account_token = var.enable_automount_service_account_token
    metrics_server_prefer_internal_kubelet_address = var.metrics_server_prefer_internal_kubelet_address
    use_first_party_jwt_tokens = var.use_first_party_jwt_tokens
  }
}

data "local_file" "apps_manager_values" {
  filename = "${path.module}/apps-manager/values.yml"
}

resource "local_file" "apps_manager_values" {
  content = data.local_file.apps_manager_values.content
  filename = "${path.module}/${var.ytt_lib_dir}/tas4k8s/vendor/configuration-values/apps-manager-values.yml"
}

data "local_file" "generated_values" {
  filename = "${path.module}/${var.ytt_lib_dir}/tas4k8s/vendor/configuration-values/deployment-values.yml"
}

resource "local_file" "cf_values_rendered" {
  content  = data.template_file.baseline_values.rendered
  filename = "${path.module}/${var.ytt_lib_dir}/tas4k8s/vendor/configuration-values/values.yml"
}

data "template_file" "postgres_pvc" {
  template = file("${path.module}/postgres/pvc.yml")

  vars = {
    postgres_instance_namespace = kubernetes_namespace.postgres.metadata[0].name
  }  
}

resource "k14s_kapp" "postgres-pvc" {
  app = "${local.postgres_instance_name}-pvc"

  namespace = "default"

  config_yaml = data.template_file.postgres_pvc.rendered

  debug_logs = true
}


data "template_file" "postgres_db_values" {
  template = file("${path.module}/postgres/values.yml")

  vars = {
    postgres_password = random_password.postgres.result
  }
}

resource "helm_release" "postgres" {
  depends_on = [k14s_kapp.postgres-pvc]

  name       = local.postgres_instance_name
  namespace  = kubernetes_namespace.postgres.metadata[0].name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "9.8.1"

  values = [data.template_file.postgres_db_values.rendered]

  timeout    = 400
}

data "template_file" "tas4k8s_cert" {
  template = file("${path.module}/templates/cert.yml")

  vars = {
    system_domain = local.system_domain
    app_domain    = local.app_domain
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
    "${path.module}/${var.ytt_lib_dir}/tas4k8s/vendor/configuration-values"
  ]

  debug_logs = true

  depends_on = [
    local_file.cf_values_rendered,
    local_file.apps_manager_values
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
    k14s_kapp.tas4k8s_cert,
    helm_release.postgres
  ]
}