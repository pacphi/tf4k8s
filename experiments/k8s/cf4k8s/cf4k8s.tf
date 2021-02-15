module "cf4k8s" {
  source = "../../../modules/cf4k8s"

  domain                = "cf.${var.base_domain}"
  registry_domain       = var.registry_domain
  repository_prefix     = var.repository_prefix
  registry_username     = var.registry_username
  registry_password     = var.registry_password

  https_only = var.https_only
  remove_resource_requirements = var.remove_resource_requirements
  add_metrics_server_components = var.add_metrics_server_components
  allow_prometheus_metrics_access = var.allow_prometheus_metrics_access
  enable_load_balancer = var.enable_load_balancer
  use_external_dns_for_wildcard = var.use_external_dns_for_wildcard
  enable_automount_service_account_token = var.enable_automount_service_account_token
  metrics_server_prefer_internal_kubelet_address = var.metrics_server_prefer_internal_kubelet_address
  use_first_party_jwt_tokens = var.use_first_party_jwt_tokens

  kubeconfig_path  = var.kubeconfig_path
  ytt_lib_dir      = var.ytt_lib_dir
}

variable "base_domain" {
   description = "An existing domain wherein a number of *.cf.<domain> wildcard domain recordsets will be made available"
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

variable "https_only" {
  default = true
}

variable "remove_resource_requirements" {
  default = true
}

variable "add_metrics_server_components" {
  default = false
}

variable "allow_prometheus_metrics_access" {
  default = false
}

variable "enable_load_balancer" {
  default = true
}

variable "use_external_dns_for_wildcard" {
  default = true
}

variable "enable_automount_service_account_token" {
  default = false
}

variable "metrics_server_prefer_internal_kubelet_address" {
  default = false
}

variable "use_first_party_jwt_tokens" {
  default = false
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

variable "ytt_lib_dir" {
  description = "Path to directory where YAML template files will be operated upon by ytt k14s Teraform provider; @see https://github.com/k14s/terraform-provider-k14s/blob/master/docs/k14s_ytt.md"
  default = "../../ytt-libs"
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