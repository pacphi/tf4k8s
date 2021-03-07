variable "cluster_name" {}

variable "wavefront_url" {}

variable "wavefront_api_token" {
  sensitive = true
}

variable "kubeconfig_path" {}
