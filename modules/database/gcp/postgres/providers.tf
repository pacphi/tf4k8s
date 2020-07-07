provider "google" {
  version     = ">=3.21.0"
  credentials = file(var.service_account_credentials)
  project     = var.project
  region      = var.region
}

provider "google-beta" {
  version     = ">=3.21.0"
  credentials = file(var.service_account_credentials)
  project     = var.project
  region      = var.region
}

terraform {
  required_version = "~> 0.12"
}
