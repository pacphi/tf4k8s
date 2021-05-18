terraform {
  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = ">= 2.4.0"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
  required_version = ">= 0.14"
}
