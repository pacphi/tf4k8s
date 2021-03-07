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
    http = {
      source = "hashicorp/http"
    }
    local = {
      source = "hashicorp/local"
    }
    random = {
      source = "hashicorp/random"
    }
    template = {
      source = "hashicorp/template"
    }
  }
  required_version = ">= 0.14"
}
