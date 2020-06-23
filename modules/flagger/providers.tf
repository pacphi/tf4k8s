provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
  version = "~> 1.2.0"
}

terraform {
  required_version = "~> 0.12"
}