terraform {
  required_providers {
    http = {
      source = "hashicorp/http"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    k14s = {
      source = "hashicorp/k14s"
    }
  }
  required_version = ">= 0.14"
}
