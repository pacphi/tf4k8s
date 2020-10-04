provider "azurerm" {
  version = ">=2.30.0"
  client_id = var.az_client_id
  subscription_id = var.az_subscription_id
  tenant_id = var.az_tenant_id
  client_secret = var.az_client_secret
  features {}
}

terraform {
  required_version = "~> 0.12"
}