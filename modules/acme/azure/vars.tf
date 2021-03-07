variable "client_id" {
  sensitive = true
}

variable "client_secret" {
  sensitive = true
}

variable "tenant_id" {
  sensitive = true
}

variable "subscription_id" {
  sensitive = true
}

variable "resource_group_name" {}

variable "email" {}

variable "common_name" {}

variable "additional_domains" {
  type    = list(string)
  default = []
}
