module "wavefront" {
  source = "../../../modules/wavefront"

  cluster_name = var.cluster_name
  wavefront_api_token = var.wavefront_api_token
  wavefront_url = var.wavefront_url
  kubeconfig_path = var.kubeconfig_path
}

variable "cluster_name" {
  description = "Name of Kubernetes cluster to be monitored by Wavefront"
}

variable "wavefront_url" {
  description = "Wavefront URL"
}

variable "wavefront_api_token" {
  description = "Wavefront API Token that may be retrieved from https://{wavefront_url}/getstarted/platform/kubernetes"
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}
