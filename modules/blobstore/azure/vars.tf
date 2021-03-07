variable "resource_group_name" {}

variable "storage_account_name" {}

variable "storage_container_name" {}

variable "az_subscription_id" {
  description = "Azure Subscription (id)"
  type = string
  sensitive = true
}

variable "az_client_id" {
  description = "Azure Service Principal (appId)"
  type = string
  sensitive = true
}

variable "az_client_secret" {
  description = "Azure Service Principal (password)"
  type = string
  sensitive = true
}

variable "az_tenant_id" {
  description = "Azure Service Principal (tenant)"
  type = string
  sensitive = true
}
