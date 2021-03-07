variable "project" {
  sensitive = true
}

variable "email" {}

variable "common_name" {}

variable "additional_domains" {
  type    = list(string)
  default = []
}
