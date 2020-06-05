data "azurerm_resource_goup" "rg" {
  name = var.resource_group_name
}

resource "azurerm_storage_account" "sac" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "sc" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.sac.name
  container_access_type = "private"
}
