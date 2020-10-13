resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = var.email
}

resource "acme_certificate" "certificate" {
  account_key_pem           = acme_registration.reg.account_key_pem
  common_name               = var.common_name
  subject_alternative_names = var.additional_domains
  recursive_nameservers     = ["8.8.8.8:53"]

  dns_challenge {
    provider = "gcloud"

    config = {
      GCE_PROJECT             = var.project
      GCE_PROPAGATION_TIMEOUT = "360"
    }
  }
}
