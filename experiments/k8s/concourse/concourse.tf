module "concourse" {
  source = "../../../modules/concourse"

  domain = var.domain
  ingress = var.ingress
  kubeconfig_path = var.kubeconfig_path
}

variable "domain" {
  description = "The base domain wherein concourse.<domain> will be deployed"
}

variable "ingress" {
  description = "Used to specify which Ingress controller should serve a particular Ingress object.  Choices are: [ contour, nginx ]."
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

output "concourse_domain" {
  value = module.concourse.concourse_domain
}

output "concourse_username" {
  value = module.concourse.concourse_username
}

output "concourse_password" {
  value = module.concourse.concourse_password
  sensitive = true
}
