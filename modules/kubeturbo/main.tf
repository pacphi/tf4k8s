// @see https://github.com/turbonomic/kubeturbo/wiki/Operator-Details

resource "kubernetes_namespace" "turbo" {
  metadata {
    name = "turbo"
  }
}

data "http" "service_account" {
  url = "https://raw.githubusercontent.com/turbonomic/kubeturbo/${var.kubeturbo_operator_commit_hash}/deploy/kubeturbo-operator/deploy/service_account.yaml"
}

data "http" "role_binding" {
  url = "https://raw.githubusercontent.com/turbonomic/kubeturbo/${var.kubeturbo_operator_commit_hash}/deploy/kubeturbo-operator/deploy/role_binding.yaml"
}

data "http" "crd" {
  url = "https://raw.githubusercontent.com/turbonomic/kubeturbo/${var.kubeturbo_operator_commit_hash}/deploy/kubeturbo-operator/deploy/crds/charts_v1alpha1_kubeturbo_crd.yaml"
}

data "http" "operator" {
  url = "https://raw.githubusercontent.com/turbonomic/kubeturbo/${var.kubeturbo_operator_commit_hash}/deploy/kubeturbo-operator/deploy/operator.yaml"
}

resource "local_file" "kubeturbo_operator_install" {
  filename = "${path.module}/operator-install.yaml"
  content = join("/n---/n", [ data.http.service_account.body, data.http.role_binding.body, data.http.crd.body, data.http.operator.body ])
}

resource "k14s_kapp" "kubeturbo_operator_install" {
  app = "kubeturbo-operator"
  namespace = "turbo"

  config_yaml = local_file.kubeturbo_operator_install.content

  depends_on = [
    kubernetes_namespace.turbo
  ]
}

data "template_file" "kubeturbo_install" {
  template = file("${path.module}/templates/charts_v1alpha1_kubeturbo_cr.tpl")

  vars = {
    turbo_username = var.turbo_username
    turbo_password = var.turbo_password
    turbo_server_url = var.turbo_server_url
    turbo_server_version = var.turbo_server_version
    k8s_cluster_name = var.k8s_cluster_name
  }
}

resource "k14s_kapp" "kubeturbo_install" {
  app = "kubeturbo"
  namespace = "turbo"

  config_yaml = data.template_file.kubeturbo_install.rendered

  depends_on = [
    k14s_kapp.kubeturbo_operator_install
  ]
}