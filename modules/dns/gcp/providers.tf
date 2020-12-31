provider "google" {
  credentials = file(var.gcp_service_account_credentials)
  project     = var.project
}
