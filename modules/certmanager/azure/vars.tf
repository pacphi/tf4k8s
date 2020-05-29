variable "az_subscription_id" {
  description = "Azure Subscription (id)"
  type = string
}

variable "az_client_id" {
  description = "Azure Service Principal (appId)"
  type = string
}

variable "az_client_secret" {
  description = "Azure Service Principal (password)"
  type = string
}

variable "az_tenant_id" {
  description = "Azure Service Principal (tenant)"
  type = string
}

variable "cluster_issuer_resource_group" {
  description = "Microsoft Azure Resource group name"
  type = string
}

variable "domain" {
  description = "A publicly addressable Internet domain"
  type = string
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
