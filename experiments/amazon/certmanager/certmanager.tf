module "certmanager" {
  source = "../../../modules/certmanager/amazon"

  access_key = var.access_key
  secret_key = var.secret_key
  region = var.region
  domain = var.domain
  hosted_zone_id = var.hosted_zone_id
  acme_email = var.acme_email

  kubeconfig_path = var.kubeconfig_path
}

variable "access_key" {
  description = "Access key for the IAM User with policy attachment that provides appropriate permissions; @see https://cert-manager.io/docs/configuration/acme/dns01/route53/#set-up-an-iam-role"
}

variable "secret_key" {
  description = "Secret key for the IAM User with policy attachment that provides appropriate permissions; @see https://cert-manager.io/docs/configuration/acme/dns01/route53/#set-up-an-iam-role"
}

variable "region" {
  description = "An AWS region (e.g., us-east-1)"
}

variable "domain" {
  description = "A publicly addressable Internet domain"
}

variable "hosted_zone_id" {
  description = " The id of a Route53 zone that the cert-manager will have access to"
}

variable "acme_email" {
  description = "A valid email address that will be used by Let's Encrypt via the ACME protocol to verify that you control a given domain name"
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}