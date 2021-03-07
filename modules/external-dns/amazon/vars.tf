variable "aws_access_key" {
  sensitive = true
}

variable "aws_secret_key" {
  sensitive = true
}

variable "region" {}

variable "domain_filter" {}

variable "kubeconfig_path" {}
