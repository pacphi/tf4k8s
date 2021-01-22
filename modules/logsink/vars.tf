
variable "tkgi_cluster_name" {}

variable "sink_hostname" {}

variable "sink_port" {
  default = 443
}

variable "sink_insecure_skip_verify" {
  default = true
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  type = string
  default = "~/.kube/config"
}