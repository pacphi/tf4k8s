terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
    }
    k14s = {
      source = "hashicorp/k14s"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    random = {
      source = "hashicorp/random"
    }
    template = {
      source = "hashicorp/template"
    }
  }
  required_version = ">= 0.13"
}
