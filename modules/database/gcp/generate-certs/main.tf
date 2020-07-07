data "google_sql_ca_certs" "ca_certs" {
  instance = var.instance_name
}

resource "google_sql_ssl_cert" "client_cert" {
  common_name = "client-cert-for-${var.instance_name}"
  instance = var.instance_name
}

resource "local_file" "ca_cert_file" {
  content = google_sql_ssl_cert.client_cert.server_ca_cert
  filename = pathexpand("~/.tf4k8s/gcp/${var.instance_name}.ssl_ca.pem")
}

resource "local_file" "cert_file" {
  content = google_sql_ssl_cert.client_cert.cert
  filename = pathexpand("~/.tf4k8s/gcp/${var.instance_name}.ssl_cert.pem")
}

resource "local_file" "key_file" {
  content = google_sql_ssl_cert.client_cert.private_key
  filename = pathexpand("~/.tf4k8s/gcp/${var.instance_name}.ssl_key.pem")
}
