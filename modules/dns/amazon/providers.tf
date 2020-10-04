provider "aws" {
  version = "~> 3.9.0"
  region  = var.region
}

terraform {
  required_version = "~> 0.12"
}
