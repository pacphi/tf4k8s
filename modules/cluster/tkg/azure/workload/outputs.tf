output "kubeconfig_contents" {
  value = file(pathexpand("~/.kube/config"))
}