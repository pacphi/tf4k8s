module "external_dns" {
  source = "../../../modules/external-dns/gcp"

  domain_filter    = var.domain_filter
  zone_id_filter   = var.zone_id_filter
  enable_istio     = var.enable_istio
  kubeconfig_path  = var.kubeconfig_path
  ytt_lib_dir      = var.ytt_lib_dir
}

variable "domain_filter" {
  description = "An existing domain"
}

variable "zone_id_filter" {
  description = "The name of an existing Google Cloud DNS zone"
}

variable "enable_istio" {
  description = "Enable Istio (e.g., true or false)"
  default = false
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

variable "ytt_lib_dir" {
  description = "Path to directory where YAML template files will be operated upon by ytt k14s Teraform provider; @see https://github.com/k14s/terraform-provider-k14s/blob/master/docs/k14s_ytt.md"
  default = "../../../ytt-libs"
}