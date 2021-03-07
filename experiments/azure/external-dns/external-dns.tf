module "external_dns" {
  source = "../../../modules/external-dns/azure"

  domain_filter    = var.domain_filter

  resource_group_name = var.resource_group_name
  az_client_id = var.az_client_id
  az_client_secret = var.az_client_secret
  az_subscription_id = var.az_subscription_id
  az_tenant_id = var.az_tenant_id

  kubeconfig_path  = var.kubeconfig_path
}

variable "az_subscription_id" {
  description = "Azure Subscription id"
  sensitive = true
}

variable "az_client_id" {
  description = "Azure Service Principal appId"
  sensitive = true
}

variable "az_client_secret" {
  description = "Azure Service Principal password"
  sensitive = true
}

variable "az_tenant_id" {
  description = "Azure Service Principal tenant"
  sensitive = true
}

variable "resource_group_name" {
  description = "Microsoft Azure Resource group name"
}

variable "domain_filter" {
  description = "An existing domain"
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}
