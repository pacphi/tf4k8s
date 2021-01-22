module "tkgi_logsink" {
  source = "../../../modules/logsink"

  tkgi_cluster_name = var.tkgi_cluster_nam
  sink_hostname = var.sink_hostname
  sink_port = var.sink_port
  sink_insecure_skip_verify = var.sink_insecure_skip_verify

  kubeconfig_path = var.kubeconfig_path
}

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
  default = "~/.kube/config"
}
