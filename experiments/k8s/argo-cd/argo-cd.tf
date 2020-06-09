module "argocd" {
  source = "../../../modules/argo-cd"

  domain = var.domain
  kubeconfig_path = var.kubeconfig_path
}

variable "domain" {
  description = "The base domain wherein argocd.<domain> will be deployed"
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

output "argocd_endpoint" {
  description = "Argo CD endpoint"
  value       = "https://${module.argocd.argocd_domain}"
}

output "argocd_admin_username" {
  description = "Argo CD admin username"
  value       = module.argocd.argocd_admin_username
}
