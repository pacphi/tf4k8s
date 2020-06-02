resource "kubernetes_namespace" "n" {
  metadata {
    name = "logging"
  }
}

module "elasticsearch" {
  source = "../../../modules/elasticsearch"

  namespace = kubernetes_namespace.n.metadata[0].name
  kubeconfig_path = var.kubeconfig_path
}

module "kibana" {
  source = "../../../modules/kibana"

  domain = var.domain
  namespace = kubernetes_namespace.n.metadata[0].name
  kubeconfig_path = var.kubeconfig_path
}

module "fluentbit" {
  source = "../../../modules/fluentbit"

  namespace = kubernetes_namespace.n.metadata[0].name
  kubeconfig_path = var.kubeconfig_path
}

module "metricbeat" {
  source = "../../../modules/metricbeat"

  namespace = kubernetes_namespace.n.metadata[0].name
  kubeconfig_path = var.kubeconfig_path
}

variable "domain" {
  description = "The base domain wherein elasticsearch, fluentbit, kibana.<domain>, and metricbeat will be deployed"
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

output "kibana_domain" {
  value = module.kibana.kibana_domain
}