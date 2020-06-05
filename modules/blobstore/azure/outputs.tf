output "storage_account_location" {
  value = azurerm_storage_account.sac.location
}

output "storage_container_id" {
  value = azurerm_storage_container.sc.id
}

output "storage_container_resource_manager_id" {
  value = azurerm_storage_container.sc.resource_manager_id
}
