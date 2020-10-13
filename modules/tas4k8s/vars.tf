variable "domain" {}

variable "certificate_variables_file_path" {
  default = ""
}

variable "registry_domain" {}

variable "repository_prefix" {}

variable "registry_username" {}

variable "registry_password" {}

variable "pivnet_registry_hostname" {}

variable "pivnet_username" {}

variable "pivnet_password" {}

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

variable "use_first_party_jwt_tokens" {
  default = "false"
}

variable "kubeconfig_path" {}

variable "ytt_lib_dir" {}