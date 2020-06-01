module "loki-stack" {
  source = "../../../modules/loki-stack"

  domain = var.domain
  kubeconfig_path = var.kubeconfig_path
}

variable "domain" {
  description = "The base domain wherein fluentbit, loki, prometheus, and grafana.<domain> as part of Loki Stack will be deployed"
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

output "grafana_username" {
  value = module.loki-stack.grafana_username
}

output "grafana_password" {
  value = module.loki-stack.grafana_password
}

output "grafana_domain" {
  value = module.loki-stack.grafana_domain
}