variable "client_id" {}

variable "client_secret" {}

variable "tenant_id" {}

variable "subscription_id" {}

variable "resource_group_name" {}

variable "email" {}

variable "common_name" {}

variable "additional_domains" {
  type    = list(string)
  default = []
}
