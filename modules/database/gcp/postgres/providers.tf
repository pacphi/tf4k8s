provider "google" {
  credentials = file(var.service_account_credentials)
  project     = var.project
  region      = var.region
}

provider "google-beta" {
  credentials = file(var.service_account_credentials)
  project     = var.project
  region      = var.region
}
