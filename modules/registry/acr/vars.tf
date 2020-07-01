variable "az_subscription_id" {
  description = "Azure Subscription id"
}

variable "az_client_id" {
  description = "Azure Service Principal appId"
}

variable "az_client_secret" {
  description = "Azure Service Principal password"
}

variable "az_tenant_id" {
  description = "Azure Service Principal tenant"
}

variable "registry_name" {
  description = "Specifies the name of the Container Registry.  This name will be updated to append a unique suffix so as not to collide with a pre-existing registry."
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Container Registry"
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists"
}