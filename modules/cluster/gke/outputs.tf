
output "path_to_kubeconfig" {
  value = local_file.kubeconfig.filename
}

output "gke_cluster_name" {
  value = google_container_cluster.gke.name
}

output "gke_node_version_deployed" {
  value = var.gke_node_version
}

output "gcp_region" {
  value = var.gcp_region
}