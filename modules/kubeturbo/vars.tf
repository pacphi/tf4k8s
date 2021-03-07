
variable "kubeturbo_operator_commit_hash" {}

variable "turbo_username" {
  sensitive = true
}
variable "turbo_password" {
  sensitive = true
}

variable "turbo_server_url" {}

variable "turbo_server_version" {}

variable "k8s_cluster_name" {}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  type = string
  default = "~/.kube/config"
}