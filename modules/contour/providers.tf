provider "k14s" {
  kapp {
    kubeconfig_yaml = file(var.kubeconfig_path)
  }
}

