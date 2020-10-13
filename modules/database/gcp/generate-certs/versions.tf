terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    local = {
      source = "hashicorp/local"
    }
  }
  required_version = ">= 0.13"
}
