variable "environment_name" {}

variable "kubernetes_version" {
  default = "1.16.4-1-amazon2"
}

variable "region" {
  default = "us-west-2"
}

variable "availability_zones" {
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "acme_email" {}

variable "base_hosted_zone_id" {}

variable "dns_prefix" {}

variable "ssh_key_name" {}

variable "node_pool_instance_type" {
  default = "t3a.large"
}

variable "tags" {
  default = {}
}