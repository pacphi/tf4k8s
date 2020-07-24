module "git" {
  source = "../../../modules/git/gitea"

  domain = var.domain
  kubeconfig_path = var.kubeconfig_path
  persistence_enabled = var.persistence_enabled
  persistence_storageclass = var.persistence_storageclass
}

variable "domain" {
  description = "The base domain wherein git.<domain> will be deployed"
}

variable "persistence_enabled" {
  description = "Create PVCs to store gitea and postgres data?"
  default = false
}

variable "persistence_storageclass" {
  description = "NStorageClass to use for dynamic provision if not 'default'"
  default = ""
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

output "git_endpoint" {
  description = "Git repository endpoint"
  value       = "https://${module.git.gitea_domain}"
}
