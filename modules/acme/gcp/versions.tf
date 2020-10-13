terraform {
  required_providers {
    acme = {
      source = "terraform-providers/acme"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
  required_version = ">= 0.13"
}
