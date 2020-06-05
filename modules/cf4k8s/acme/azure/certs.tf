locals {
  cf_domain = "cf.${var.domain}"
}

module "system_cert" {
  source = "../../../acme/azure"

  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
  subscription_id = var.subscription_id
  resource_group_name = var.resource_group_name
  email = var.email
  common_name = "*.${local.cf_domain}"
  additional_domains = [ "*.login.${local.cf_domain}", "*.uaa.${local.cf_domain}" ]
}

module "workloads_cert" {
  source = "../../../acme/azure"

  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
  subscription_id = var.subscription_id
  resource_group_name = var.resource_group_name
  email = var.email
  common_name = "*.apps.${local.cf_domain}"
}

resource "local_file" "certs_var_file" {
  content = join(
    "\n", [
      "system_fullchain_certificate = ${base64encode(module.system_cert.cert_full_chain)}",
      "system_private_key = ${base64encode(module.system_cert.cert_key)}",
      "workloads_fullchain_certificate = ${base64encode(module.workloads_cert.cert_full_chain)}",
      "workloads_private_key = ${base64encode(module.workloads_cert.cert_key)}"
    ]
  )
  filename = "../../certs.auto.tfvars"
}

variable "client_id" {}

variable "client_secret" {}

variable "tenant_id" {}

variable "subscription_id" {}

variable "resource_group_name" {}

variable "email" {}

variable "domain" {}
