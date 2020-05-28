provider "aws" {
  version = "~> 2.0"
  region  = var.region
}

terraform {
  required_version = "~> 0.12"
}
