module "external_dns" {
  source = "../../../modules/external-dns/gcp"

  domain_filter    = var.domain_filter
  kubeconfig_path  = var.kubeconfig_path
  gcp_project = var.gcp_project
  gcp_service_account_credentials = var.gcp_service_account_credentials
}

variable "domain_filter" {
  description = "An existing domain"
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

variable "gcp_project" {
  description = "A Google Cloud Platform project id"
}

variable "gcp_service_account_credentials" {
  description = "Path to service account credentials file in JSON format"
}