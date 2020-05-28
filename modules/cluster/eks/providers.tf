provider "aws" {
  region = var.region

  version = "~> 2.54.0"
}

terraform {
  required_version = "~> 0.12"
}