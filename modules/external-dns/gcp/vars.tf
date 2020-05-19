variable "environment_name" {}

variable "namespace" {
  default = "external-dns"
}

variable "domain_filter" {
  default = ""
}

variable "zone_id_filter" {
  default = ""
}

variable "enable_istio" {
  default = false
}

variable "ytt_lib_dir" {}