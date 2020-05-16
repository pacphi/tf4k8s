provider "google" {
  version     = ">=2.11.0"
  credentials = file("account.json")
  project     = var.gcp_project
  region      = var.gcp_region
}