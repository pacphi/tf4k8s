output "cert_full_chain" {
  value = "${acme_certificate.certificate.certificate_pem}${acme_certificate.certificate.issuer_pem}"
}

output "cert" {
  value = acme_certificate.certificate.certificate_pem
}

output "cert_key" {
  value = acme_certificate.certificate.private_key_pem
}

output "cert_ca" {
  value = acme_certificate.certificate.issuer_pem
}