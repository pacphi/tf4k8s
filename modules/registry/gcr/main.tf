resource "google_container_registry" "reg" {
  project  = var.project
  location = var.location
}

data "google_container_registry_repository" "repo" {
  project  = var.project
  region = var.location

  depends_on = [ google_container_registry.reg ]
}
