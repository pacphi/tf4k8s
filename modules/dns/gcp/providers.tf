provider "google" {
  version = ">=3.21.0"
  project = var.project
}

terraform {
  required_version = "~> 0.12"
}
