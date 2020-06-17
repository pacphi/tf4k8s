variable "domain" {}

variable "ingress" {
  description = "Used to specify which Ingress controller should serve a particular Ingress object.  The only choice for now is [ nginx ]."
  default = "nginx"
}

variable "kubeconfig_path" {}
