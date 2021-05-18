module "harbor" {
  source = "../../../modules/registry/harbor"

  domain = var.domain
  ingress = var.ingress
  kubeconfig_path = var.kubeconfig_path
}

variable "domain" {
  description = "The base domain wherein harbor.<domain> will be deployed"
}

variable "ingress" {
  description = "Used to specify which Ingress controller should serve a particular Ingress object.  Choices are: [ contour, nginx ]."
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

output "harbor_endpoint" {
  description = "Harbor registry endpoint"
  value       = "https://${module.harbor.harbor_domain}"
}

output "harbor_admin_username" {
  description = "Harbor registry admin username"
  value       = module.harbor.harbor_admin_username
}

output "harbor_admin_password" {
  description = "Harbor registry admin password"
  value       = module.harbor.harbor_admin_password
  sensitive = true
}

