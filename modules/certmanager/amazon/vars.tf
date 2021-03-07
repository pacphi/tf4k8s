variable "access_key" {
  description = "Access key for the IAM User with policy attachment that provides appropriate permissions; @see https://cert-manager.io/docs/configuration/acme/dns01/route53/#set-up-an-iam-role"
  type = string
  sensitive = true
}

variable "secret_key" {
  description = "Secret key for the IAM User with policy attachment that provides appropriate permissions; @see https://cert-manager.io/docs/configuration/acme/dns01/route53/#set-up-an-iam-role"
  type = string
  sensitive = true
}

variable "domain" {
  description = "A publicly addressable Internet domain"
  type = string
}

variable "hosted_zone_id" {
  description = " The id of a Route53 zone that the cert-manager will have access to"
  type = string
}

variable "region" {
  description = "An AWS region (e.g., us-east-1)"
  type = string
  default = "us-west-2"
}

variable "acme_email" {
  description = "A valid email address that will be used by Let's Encrypt via the ACME protocol to verify that you control a given domain name"
  type = string
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  type = string
  default = "~/.kube/config"
}
