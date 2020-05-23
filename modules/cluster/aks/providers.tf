provider "azurerm" {
  version = ">=2.0.0"
  client_id = var.az_client_id
  subscription_id = var.az_subscription_id
  tenant_id = var.az_tenant_id
  features {}
}

terraform {
  required_version = "~> 0.12"
}