locals {
  cf_domain = "tas.${var.domain}"
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

data "template_file" "certs_and_keys" {
  template = file("${path.module}/../templates/certs-and-keys.tpl")

  vars = {
    system_certificate_full_chain = indent(4, module.system_cert.cert_full_chain)
    system_cert_key = indent(4, module.system_cert.cert_key)
    workloads_certificate_full_chain = indent(4, module.workloads_cert.cert_full_chain)
    workloads_cert_key = indent(4, module.workloads_cert.cert_key)
  }
}
resource "local_file" "certs_and_keys_file" {
  content = data.template_file.certs_and_keys.rendered
  filename = "../../certs-and-keys.yml"
}

variable "client_id" {}

variable "client_secret" {}

variable "tenant_id" {}

variable "subscription_id" {}

variable "resource_group_name" {}

variable "email" {}

variable "domain" {}
