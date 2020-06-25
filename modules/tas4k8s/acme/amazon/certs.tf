locals {
  cf_domain = "tas.${var.domain}"
}

module "system_cert" {
  source = "../../../acme/amazon"

  dns_zone_id = var.dns_zone_id
  email = var.email
  common_name = "*.${local.cf_domain}"
  additional_domains = [ "*.login.${local.cf_domain}", "*.uaa.${local.cf_domain}" ]
}

module "workloads_cert" {
  source = "../../../acme/amazon"

  dns_zone_id = var.dns_zone_id
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

variable "dns_zone_id" {}

variable "email" {}

variable "domain" {}
