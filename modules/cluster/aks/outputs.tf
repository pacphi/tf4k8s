output "kubeconfig_path_aks" {
  value = local_file.kubeconfigaks.filename
}

output "latest_k8s_version" {
  value = data.azurerm_kubernetes_service_versions.current.*.latest_version
}

output "public_ip_address" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "public_ip_fqdn" {
  value = azurerm_public_ip.public_ip.fqdn
}