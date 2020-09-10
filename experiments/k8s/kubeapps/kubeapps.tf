module "kubeapps" {
  source = "../../../modules/kubeapps"

  domain = var.domain
  ingress = var.ingress
  kubeconfig_path = var.kubeconfig_path
}

variable "domain" {
  description = "The base domain wherein fluentbit, loki, prometheus, and grafana.<domain> as part of Loki Stack will be deployed"
}

variable "ingress" {
  description = "Used to specify which Ingress controller should serve a particular Ingress object.  Choices are: [ contour, nginx ]."
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

output "kubeapps_domain" {
  value = module.kubeapps.kubeapps_domain
}