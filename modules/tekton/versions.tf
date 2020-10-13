terraform {
  required_providers {
    k14s = {
      source = "hashicorp/k14s"
    }
    local = {
      source = "hashicorp/local"
    }
  }
  required_version = ">= 0.13"
}
