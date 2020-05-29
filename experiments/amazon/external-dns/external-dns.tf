module "external_dns" {
  source = "../../../modules/external-dns/amazon"

  domain_filter    = var.domain_filter
  aws_access_key   = var.aws_access_key
  aws_secret_key   = var.aws_secret_key
  region           = var.region
  kubeconfig_path  = var.kubeconfig_path
}

variable "aws_access_key" {
  description = "Access key for the IAM User with policy attachment that provides appropriate permissions to set records in Route53 zone"
}

variable "aws_secret_key" {
  description = "Secret key for the IAM User with policy attachment that provides appropriate permissions to set records in Route53 zone"
}

variable "region" {
  description = "An AWS region (e.g., us-east-1)"
  default = "us-west-2"
}

variable "domain_filter" {
  description = "An existing domain"
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}
