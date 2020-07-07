output "ssl_key" {
  value = local_file.key_file.filename
}

output "ssl_cert" {
  value = local_file.cert_file.filename
}

output "ssl_ca" {
  value = local_file.ca_cert_file.filename
}
