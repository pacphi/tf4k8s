variable "eks_name" {}

variable "desired_nodes" {
  description = "Desired number of worker nodes"
  default = 1
}

variable "min_nodes" {
  description = "Minimum number of worker nodes"
  default = 1
}

variable "max_nodes" {
  description = "Maximum number of worker nodes"
  default = 1
}

variable "kubernetes_version" {
  default = "1.16.4-1-amazon2"
}

variable "region" {
  default = "us-west-2"
}

variable "availability_zones" {
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "ssh_key_name" {}

variable "node_pool_instance_type" {
  default = "t3a.large"
}

variable "tags" {
  default = {}
}