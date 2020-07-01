output "gcr_bucket_id" {
  description = "The name of the bucket that supports the Container Registry"
  value = google_container_registry.reg.id
}

output "gcr_repository_url" {
  description = "The URL at which the repository can be accessed"
  value = data.google_container_registry_repository.repo.repository_url
}
