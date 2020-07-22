variable "project" {
  description = "A Google Cloud Platform project id"
  type = string
}

variable "domain" {
  description = "A publicly addressable Internet domain"
  type = string
}

variable "acme_email" {
  description = "A valid email address that will be used by Let's Encrypt via the ACME protocol to verify that you control a given domain name"
  type = string
}

variable "dns_zone_name" {
  description = "A Google Cloud DNS zone name"
  type = string
}

variable "gcp_service_account_credentials" {
  description = "Path to service account credentials file in JSON format"
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  type = string
  default = "~/.kube/config"
}