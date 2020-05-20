variable "namespace" {
  default = "external-dns"
}

variable "domain_filter" {}

variable "zone_id_filter" {}

variable "dns_provider" {}

variable "values" {
  type = map
  default = {}
}

variable "enable_istio" {
  default = false
}

variable "kubeconfig_path" {}
