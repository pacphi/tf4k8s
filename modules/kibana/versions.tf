terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 1.3.1"
    }
    k14s = {
      source = "hashicorp/k14s"
    }
    template = {
      source = "hashicorp/template"
    }
  }
  required_version = ">= 0.14"
}
