provider "google" {
  version     = ">=3.21.0"
  credentials = file(var.gcp_service_account_credentials)
  project     = var.project
}
