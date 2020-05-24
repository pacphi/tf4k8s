module "external_dns" {
  source = "../../../modules/external-dns/azure"

  domain_filter    = var.domain_filter

  resource_group_name = var.resouce_group_name
  az_client_id = var.az_client_id
  az_subscription_id = var.az_subscription_id
  az_tenant_id = var.az_tenant_id

  kubeconfig_path  = var.kubeconfig_path
}

variable "az_subscription_id" {
  description = "Azure Subscription id"
}

variable "az_client_id" {
  description = "Azure Service Principal appId"
}

variable "az_tenant_id" {
  description = "Azure Service Principal tenant"
}

variable "resource_group_name" {
  description = "Microsoft Azure Resource group name"
}

variable "domain_filter" {
  description = "An existing domain"
}

variable "kubeconfig_path" {
  description = "The path to your .kubeconfig"
  default = "~/.kubeconfig"
}
