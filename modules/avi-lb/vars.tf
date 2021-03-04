variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
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