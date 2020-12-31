provider "google" {
  credentials = file(var.gcp_service_account_credentials)
  project     = var.gcp_project
  region      = var.gcp_region
}

provider "google-beta" {
  credentials = file(var.gcp_service_account_credentials)
  project     = var.gcp_project
  region      = var.gcp_region
}

