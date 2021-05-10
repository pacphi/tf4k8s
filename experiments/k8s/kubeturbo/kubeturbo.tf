module "kubeturbo" {
  source = "../../../modules/kubeturbo"

  kubeconfig_path = var.kubeconfig_path
  kubeturbo_operator_commit_hash = var.kubeturbo_operator_commit_hash
  turbo_username = var.turbo_username
  turbo_password = var.turbo_password
  turbo_server_url = var.turbo_server_url
  turbo_server_version = var.turbo_server_version
  k8s_cluster_name = var.k8s_cluster_name
}

variable "kubeturbo_operator_commit_hash" {
  // this commit hash corresponds to the 8.1.6 release
  default = "ab9408f5e1359c6e86131e9d4456fdd104e20ab6"
}

variable "turbo_username" {
  sensitive = true
}

variable "turbo_password" {
  sensitive = true
}

variable "turbo_server_url" {}

variable "turbo_server_version" {
  default = "8.0.6"
}

variable "k8s_cluster_name" {}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}
