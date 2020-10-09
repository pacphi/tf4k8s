variable "project" {}

variable "gcp_service_account_credentials" {
  description = "Path to service account credentials file in JSON format"
  type        = string
}

variable "root_zone_name" {}

variable "environment_name" {}

variable "dns_prefix" {}