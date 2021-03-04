terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 1.3.1"
    }
    http = {
      source = "hashicorp/http"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
  required_version = ">= 0.13"
}
