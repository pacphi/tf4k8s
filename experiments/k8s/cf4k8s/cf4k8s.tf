module "cf4k8s" {
  source = "../../../modules/cf4k8s"

  domain           = "cf.${var.base_domain}"
  registry_domain  = var.registry_domain
  registry_repository   = var.registry_repository
  registry_username     = var.registry_username
  registry_password     = var.registry_password
  kubeconfig_path  = var.kubeconfig_path
  ytt_lib_dir      = var.ytt_lib_dir
}

variable "base_domain" {
   description = "An existing domain wherein a number of *.cf.<domain> wildcard domain recordsets will be made available"
}

variable "registry_domain" {
  description = "Container image/artifact registry/repository domain"
}

variable "registry_repository" {
 description = "Container image/artifact registry/repository name"
}

variable "registry_username" {
  description = "Container image/artifact registry/repository username"
  default "admin"
}

variable "registry_password" {
  description = "Container image/artifact registry/repository password"
}

variable "kubeconfig_path" {
  description = "The path to your .kubeconfig"
  default = "~/.kubeconfig"
}

variable "ytt_lib_dir" {
  description = "Path to directory where YAML template files will be operated upon by ytt k14s Teraform provider; @see https://github.com/k14s/terraform-provider-k14s/blob/master/docs/k14s_ytt.md"
  default = "../../../ytt-libs"
}

output "cf_api_endpoint" {
  description = "Cloud Foundry API endpoint"
  value       = module.cf4k8s.cf_api_endpoint
}

output "cf_admin_username" {
  description = "Cloud Foundry admin username"
  value       = module.cf4k8s.cf_admin_username
}

output "cf_admin_password" {
  description = "Cloud Foundry admin password"
  value       = module.cf4k8s.cf_admin_password
}