provider "google" {
  version     = ">=2.11.0"
  credentials = file(var.gcp_service_account_credentials)
  project     = var.gcp_project
  region      = var.gcp_region
}