terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
    }
    k14s = {
      source = "hashicorp/k14s"
    }
    template = {
      source = "hashicorp/template"
    }
  }
  required_version = ">= 0.13"
}
