module "external_dns" {
  source = "../../../modules/external-dns/gcp"

  environment_name = var.environment_name
  domain_filter    = var.domain_filter
  zone_id_filter   = var.zone_id_filter
  enable_istio     = var.enable_istio
  kubeconfig_path  = var.kubeconfig_path
}

variable "environemnt_variable" {
  description = "An environment name"
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
  description = "The path to your .kubeconfig"
  default = "~/.kubeconfig"
}