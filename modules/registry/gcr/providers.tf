provider "google" {
  version     = ">=3.21.0"
  credentials = file(var.credentials)
  project     = var.project
}
