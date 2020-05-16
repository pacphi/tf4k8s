
output "path_to_kubeconfig" {
  value = local_file.kubeconfig.filename
}

output "gke_node_version_deployed" {
  value = var.gke_node_version
}
