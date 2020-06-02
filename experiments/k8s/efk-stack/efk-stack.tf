data "kubernetes_namespace" "n" {
  metadata {
    name = "logging"
  }
}

module "elasticsearch" {
  source = "../../../modules/elasticsearch"

  namespace = data.kubernetes_namespace.n.metadata[0].name
  kubeconfig_path = var.kubeconfig_path
}

module "kibana" {
  source = "../../../modules/kibana"

  domain = var.domain
  namespace = data.kubernetes_namespace.n.metadata[0].name
  kubeconfig_path = var.kubeconfig_path
}

module "fluentbit" {
  source = "../../../modules/fluentbit"

  namespace = data.kubernetes_namespace.n.metadata[0].name
  kubeconfig_path = var.kubeconfig_path
  ytt_lib_dir = var.ytt_lib_dir
}

variable "domain" {
  description = "The base domain wherein elasticsearch, fluentbit, and kibana.<domain> will be deployed"
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

variable "ytt_lib_dir" {
  description = "Path to directory where YAML template files will be operated upon by ytt k14s Teraform provider; @see https://github.com/k14s/terraform-provider-k14s/blob/master/docs/k14s_ytt.md"
  default = "../../ytt-libs"
}

output "kibana_domain" {
  value = module.kibana.kibana_domain
}