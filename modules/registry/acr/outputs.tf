output "acr_id" {
  description = "The ID of the Container Registry"
  value = azurerm_container_registry.acr.id
}

output "acr_name" {
  value = join("", [ var.registry_name, random_id.suffix.hex ])
}

output "acr_url" {
  description = "The URL that can be used to log into the container registry"
  value = azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
  description = "The username associated with the Container Registry admin account"
  value = azurerm_container_registry.acr.admin_username
}

output "acr_admin_password" {
  description = "The password associated with the Container Registry admin account"
  value = azurerm_container_registry.acr.admin_password
}