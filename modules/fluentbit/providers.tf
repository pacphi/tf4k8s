provider "k14s" {
  kapp {
    kubeconfig_yaml = file(var.kubeconfig_path)
  }
}

terraform {
  required_version = "~> 0.12"
}
