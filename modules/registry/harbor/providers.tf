provider "kubernetes" {
  config_path = var.kubeconfig_path
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

provider "k14s" {
  kapp {
    kubeconfig_yaml = file(var.kubeconfig_path)
  }
}

