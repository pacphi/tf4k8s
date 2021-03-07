variable "base_domain" {}

variable "domain_prefix" {}

variable "resource_group_name" {}

variable "az_client_id" {
  sensitive = true
}

variable "az_client_secret" {
  sensitive = true
}

variable "az_subscription_id" {
  sensitive = true
}

variable "az_tenant_id" {
  sensitive = true
}
