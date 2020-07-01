resource "random_id" "suffix" {
  byte_length = 4
}

resource "azurerm_container_registry" "acr" {
  name                     = join("", [ var.registry_name, random_id.suffix.hex ])
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = "Standard"
  admin_enabled            = true
}