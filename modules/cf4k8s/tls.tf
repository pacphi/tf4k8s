provider "tls" {
  version = "~> 2.0.0"
}

resource "tls_private_key" "acme_ca" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "tls_self_signed_cert" "acme_ca" {
  key_algorithm     = "RSA"
  private_key_pem   = tls_private_key.acme_ca.private_key_pem
  is_ca_certificate = true

  subject {
    common_name         = "Acme Self Signed CA"
    organization        = "Acme Self Signed"
    organizational_unit = "acme"
  }

  validity_period_hours = 87659

  allowed_uses = [
    "digital_signature",
    "cert_signing",
    "crl_signing",
  ]
}

resource "tls_private_key" "cf" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "tls_cert_request" "cf" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.cf.private_key_pem

  dns_names = ["*.cf-system.svc.cluster.local"]

  subject {
    common_name         = "*.${local.system_domain}"
    organization        = "CF Self Signed"
    country             = "US"
    organizational_unit = "Cloud Foundry"
  }
}

resource "tls_locally_signed_cert" "cf" {
  cert_request_pem   = tls_cert_request.cf.cert_request_pem
  ca_key_algorithm   = "RSA"
  ca_private_key_pem = tls_private_key.acme_ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.acme_ca.cert_pem

  validity_period_hours = 87659

  allowed_uses = [
    "digital_signature",
    "key_encipherment",
    "server_auth",
    "client_auth",
  ]
}