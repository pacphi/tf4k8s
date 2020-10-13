terraform {
  required_providers {
    http = {
      source = "hashicorp/http"
    }
    k14s = {
      source = "hashicorp/k14s"
    }
  }
  required_version = ">= 0.13"
}
