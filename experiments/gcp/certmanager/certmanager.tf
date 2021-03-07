module "certmanager" {
  source = "../../../modules/certmanager/gcp"

  project = var.project
  domain = var.domain
  acme_email = var.acme_email
  dns_zone_name = var.dns_zone_name
  gcp_service_account_credentials = var.gcp_service_account_credentials 
  kubeconfig_path = var.kubeconfig_path
}

variable "project" {
  description = "A Google Cloud Platform project id"
  sensitive = true
}

variable "domain" {
  description = "A publicly addressable Internet domain"
}

variable "acme_email" {
  description = "A valid email address that will be used by Let's Encrypt via the ACME protocol to verify that you control a given domain name"
}

variable "dns_zone_name" {
  description = "A Google Cloud DNS zone name"
}

variable "gcp_service_account_credentials" {
  description = "Path to service account credentials file in JSON format"
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}