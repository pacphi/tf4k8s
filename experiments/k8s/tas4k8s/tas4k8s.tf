module "tas4k8s" {
  source = "../../../modules/tas4k8s"

  domain           = "tas.${var.base_domain}"

  registry_domain  = var.registry_domain
  repository_prefix   = var.repository_prefix
  registry_username     = var.registry_username
  registry_password     = var.registry_password
  
  pivnet_registry_hostname = var.pivnet_registry_hostname
  pivnet_username     = var.pivnet_username
  pivnet_password     = var.pivnet_password

  remove_resource_requirements = var.remove_resource_requirements
  add_metrics_server_components = var.add_metrics_server_components
  enable_load_balancer = var.enable_load_balancer
  use_external_dns_for_wildcard = var.use_external_dns_for_wildcard
  enable_automount_service_account_token = var.enable_automount_service_account_token
  metrics_server_prefer_internal_kubelet_address = var.metrics_server_prefer_internal_kubelet_address

  kubeconfig_path  = var.kubeconfig_path
  ytt_lib_dir      = var.ytt_lib_dir
}

variable "base_domain" {
   description = "An existing domain wherein a number of *.tas.<domain> wildcard domain recordsets will be made available"
}

variable "registry_domain" {
  description = "Container image/artifact registry/repository domain"
}

variable "repository_prefix" {
 description = "Container image/artifact registry/repository name"
}

variable "registry_username" {
  description = "Container image/artifact registry/repository username"
  default = "admin"
}

variable "registry_password" {
  description = "Container image/artifact registry/repository password"
}

variable "pivnet_registry_hostname" {
  description = "Tanzu Network image/artifact registry hostname.  (This is the source of tas4k8s install images)."
  default = "registry.pivotal.io"
}

variable "pivnet_username" {
  description = "Tanzu Network image/artifact registry/repository username"
}

variable "pivnet_password" {
  description = "Tanzu Network image/artifact registry/repository password"
}

variable "remove_resource_requirements" {
  default = "false"
}

variable "add_metrics_server_components" {
  default = "false"
}

variable "enable_load_balancer" {
  default = "true"
}

variable "use_external_dns_for_wildcard" {
  default = "true"
}

variable "enable_automount_service_account_token" {
  default = "false"
}

variable "metrics_server_prefer_internal_kubelet_address" {
  default = "false"
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

variable "ytt_lib_dir" {
  description = "Path to directory where YAML template files will be operated upon by ytt k14s Teraform provider; @see https://github.com/k14s/terraform-provider-k14s/blob/master/docs/k14s_ytt.md"
  default = "../../ytt-libs"
}

output "tas_api_endpoint" {
  description = "Cloud Foundry API endpoint"
  value       = module.tas4k8s.tas_api_endpoint
}

output "tas_admin_username" {
  description = "Cloud Foundry admin username"
  value       = module.tas4k8s.tas_admin_username
}

output "tas_admin_password" {
  description = "Cloud Foundry admin password"
  value       = module.tas4k8s.tas_admin_password
}