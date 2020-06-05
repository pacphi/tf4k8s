module "azure_blobstore" {
  source = "../../../modules/blobstore/azure"

  az_subscription_id = var.az_subscription_id
  az_client_id = var.az_client_id
  az_client_secret = var.az_client_secret
  az_tenant_id = var.az_tenant_id
  resource_group_name = var.resource_group_name
  storage_account_name = var.storage_account_name
  storage_container_name = var.storage_container_name
}

variable "az_subscription_id" {
  description = "Azure Subscription (id)"
  type = string
}

variable "az_client_id" {
  description = "Azure Service Principal (appId)"
  type = string
}

variable "az_client_secret" {
  description = "Azure Service Principal (password)"
  type = string
}

variable "az_tenant_id" {
  description = "Azure Service Principal (tenant)"
  type = string
}

variable "resource_group_name" {}

variable "storage_account_name" {}

variable "storage_container_name" {}

output "storage_account_location" {
  value = module.azure_blobstore.location
}

output "storage_container_id" {
  value = module.azure_blobstore.id
}

output "storage_container_resource_manager_id" {
  value = module.azure_blobstore.resource_manager_id
}