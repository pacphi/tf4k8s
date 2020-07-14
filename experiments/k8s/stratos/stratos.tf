module "stratos" {
  source = "../../../modules/stratos"

  domain = var.domain
  ingress = var.ingress
  kubeconfig_path = var.kubeconfig_path
}

variable "domain" {
  description = "The base domain wherein stratos.<domain> will be deployed"
}

variable "ingress" {
  description = "Used to specify which Ingress controller should serve a particular Ingress object.  Choices are: [ contour, nginx ]."
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

output "stratos_domain" {
  value = module.stratos.stratos_domain
}
