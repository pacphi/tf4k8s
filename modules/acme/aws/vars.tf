variable "dns_zone_id" {}

variable "email" {}

variable "common_name" {}

variable "additional_domains" {
  type    = list(string)
  default = []
}