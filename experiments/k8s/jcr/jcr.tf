module "jcr" {
  source = "../../../modules/registry/jcr"

  domain = var.domain
  ingress = var.ingress
  kubeconfig_path = var.kubeconfig_path
}

variable "domain" {
  description = "The base domain wherein jcr.<domain> will be deployed"
}

variable "ingress" {
  description = "Used to specify which Ingress controller should serve a particular Ingress object.  Choices are: [ contour, nginx ]."
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

output "jcr_endpoint" {
  description = "jcr registry endpoint"
  value       = "https://${module.jcr.jcr_domain}"
}

output "jcr_admin_username" {
  description = "jcr registry admin username"
  value       = module.jcr.jcr_admin_username
}

output "jcr_admin_password" {
  description = "jcr registry admin password"
  value       = module.jcr.jcr_admin_password
  sensitive = true
}

output "jcr_postgresql_password" {
  value       = module.jcr.jcr_postgresql_password
  sensitive = true
}
