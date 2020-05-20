module "harbor" {
  source = "../../../modules/harbor"

  domain = var.domain
  kubeconfig_path = var.kubeconfig_path
}

variable "domain" {
  description = "The base domain wherein harbor.<domain> will be deployed"
}

variable "kubeconfig_path" {
  description = "The path to your .kubeconfig"
  default = "~/.kubeconfig"
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
}

