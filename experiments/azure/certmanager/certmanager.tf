module "certmanager" {
  source = "../../../modules/certmanager/azure"

  az_subscription_id = var.az_subscription_id
  az_client_id = var.az_client_id
  az_client_secret = var.az_client_secret
  az_tenant_id = var.az_tenant_id
  cluster_issuer_resource_group = var.cluster_issuer_resource_group
  domain = var.domain
  acme_email = var.acme_email

  kubeconfig_path = var.kubeconfig_path
}

variable "az_subscription_id" {
  description = "Azure Subscription id"
}

variable "az_client_id" {
  description = "Azure Service Principal appId"
}

variable "az_client_secret" {
  description = "Azure Service Principal password"
}

variable "az_tenant_id" {
  description = "Azure Service Principal tenant"
}

variable "cluster_issuer_resource_group" {
  description = "Microsoft Azure Resource group name"
}

variable "domain" {
  description = "A publicly addressable Internet domain"
}

variable "acme_email" {
  description = "A valid email address that will be used by Let's Encrypt via the ACME protocol to verify that you control a given domain name"
}

variable "kubeconfig_path" {
  description = "The path to your .kubeconfig"
  default = "~/.kubeconfig"
}