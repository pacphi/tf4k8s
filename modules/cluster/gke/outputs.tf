
output "path_to_kubeconfig" {
  value = local_file.kubeconfig.filename
}

output "gke_cluster_name" {
  value = google_container_cluster.gke.name
}

output "gke_node_version_deployed" {
  value = google_container_cluster.gke.master_version
}

output "gcp_region" {
  value = var.gcp_region
}