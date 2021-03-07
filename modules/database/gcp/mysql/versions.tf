terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=3.21.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">=3.21.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  required_version = ">= 0.14"
}
