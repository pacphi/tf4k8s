module "loki-stack" {
  source = "../../../modules/loki-stack"

  domain = var.domain
  kubeconfig_path = var.kubeconfig_path
}

variable "domain" {
  description = "The base domain wherein fluentbit, grafana.<domain> and prometheus.<domain> as part of loki-stack will be deployed"
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}