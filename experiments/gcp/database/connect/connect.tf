module "cloudsql_connect" {
  source = "../../../../modules/database/gcp/generate-certs"

  project = var.project
  region = var.region
  instance_name = var.instance_name
  service_account_credentials = var.service_account_credentials
}

variable "project" {
  description = "The project ID to manage the Cloud SQL resources"
}

variable "region" {
  description = "The region of the Cloud SQL resources"
  default = "us-west1"
}

variable "instance_name" {
  description = "The name of an existing Cloud SQL database instance"
}

variable "database_name" {
  description = "The name of an existing database within Cloud SQL database instance"
  default = "default"
}

variable "database_username" {
  description = "The name of a database instance user"
  default = "default"
}

variable "instance_public_ip_address" {
  description = "The public IP address of the master instance of the Cloud SQL database"
}

variable "service_account_credentials" {
  description = "Path to service account credentials file in JSON format"
}

output "ssl_key" {
  value = module.cloudsql_connect.ssl_key
}

output "ssl_cert" {
  value = module.cloudsql_connect.ssl_cert
}

output "ssl_ca" {
  value = module.cloudsql_connect.ssl_ca
}

output "mysql_client_encypted_connection_command" {
  value = "mysql --host=${var.instance_public_ip_address} --ssl-key=${module.cloudsql_connect.ssl_key} --ssl-cert=${module.cloudsql_connect.ssl_cert} --ssl-ca=${module.cloudsql_connect.ssl_ca} -u ${var.database_username} -p"
}

output "psql_client_encypted_connection_command" {
  value = "psql \"sslmode=verify-ca hostaddr=${var.instance_public_ip_address} sslkey=${module.cloudsql_connect.ssl_key} sslcert=${module.cloudsql_connect.ssl_cert} sslrootcert=${module.cloudsql_connect.ssl_ca} user=${var.database_username} dbname=${var.database_name}\""
}
