module "avi_lb" {
  source = "../../../modules/avi-lb"

  avi_hostname = var.avi_hostname
  avi_cluster_name = var.avi_cluster_name
  avi_cni_plugin = var.avi_cni_plugin
  avi_controller_username = var.avi_controller_username
  kubeconfig_path = var.kubeconfig_path
}

variable "avi_hostname" {}

variable "avi_cluster_name" {
  default = "my-avi-cluster"
}

variable "avi_cni_plugin" {
  default = "calico"
}

variable "avi_controller_username" {
  default = "admin"
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

output "avi_controller_username" {
  value = module.avi_lb.avi_controller_username
}

output "avi_controller_password" {
  value = module.avi_lb.avi_controller_password
}
