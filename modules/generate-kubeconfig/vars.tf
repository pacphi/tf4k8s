variable "directory" {}

variable "filename" {}

variable "endpoint" {}

variable "token" {}

variable "certificate_ca" {
  sensitive = true
}

variable "username" {
  sensitive = true
}

variable "cluster_name" {}

variable "context_name" {}
