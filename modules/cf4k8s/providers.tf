provider "kubernetes" {
  config_path = var.kubeconfig_path
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
  version = "~> 1.3.1"
}

provider "k14s" {
  kapp {
    kubeconfig_yaml = file(var.kubeconfig_path)
  }
}

terraform {
  required_version = "~> 0.12"
}
