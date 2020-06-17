module "contour" {
  source = "../../../modules/contour"

  kubeconfig_path = var.kubeconfig_path
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}
