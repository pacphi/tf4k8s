module "cloudsql_postgres" {
  source = "../../../../modules/database/gcp/postgres"
  
  authorized_networks = var.authorized_networks
  database_version = var.database_version
  database_tier = var.database_tier
  database_username = var.database_username
  encryption_key_name = var.encryption_key_name
  name = var.name
  project = var.project
  region = var.region
  zone = var.zone
  additional_databases = var.additional_databases
  additional_users = var.additional_users
  service_account_credentials = var.service_account_credentials
}

variable "authorized_networks" {
  description = "A list of authorized networks where each item in list has the following attributes [ name, value, expiration_time ].  The value in each item is a CIDR notation IPv4 or IPv6 address that is allowed to access this instance. Note that the value in each item must be set even if other two attributes are not for the whitelist to become active."
  default = [ { name = "open-to-all", value = "0.0.0.0/0" } ]
}

variable "database_version" {
  # POSTGRES_9_6,POSTGRES_10, POSTGRES_11, or POSTGRES_12
  description = "The database version to use. (@see https://www.terraform.io/docs/providers/google/r/sql_database_instance.html#database_version)"
  default = "POSTGRES_12"
}

variable "database_tier" {
  description = "The tier of compute used for the database instance"
  default = "db-f1-micro"
}

variable "database_username" {
  description = "The name of the database instance default user"
  default = "default"
  sensitive = true
}

variable "encryption_key_name" {
  description = "The full path to the encryption key used for the CMEK disk encryption"
  default = ""
  sensitive = true
}

variable "name" {
  description = "The name of the Cloud SQL resources"
}

variable "project" {
  description = "The project ID to manage the Cloud SQL resources"
  sensitive = true
}

variable "region" {
  description = "The region of the Cloud SQL resources"
  default = "us-west1"
}

variable "zone" {
  description = "The zone for the master instance, it should be something like: `a`, `c`"
  default = "a"
}

variable "additional_databases" {
  # list(object({ project = string name = string charset = string collation = string instance = string }))
  description = "A list of databases to be created in your cluster"
  default = []
}

variable "additional_users" {
  # list(object({ project = string name = string password = string host = string instance = string }))
  description = "A list of users to be created in your cluster"
  default = []
}

variable "service_account_credentials" {
  description = "Path to service account credentials file in JSON format"
}

output "db_username" {
  value = var.database_username
}

output "db_password" {
  value = module.cloudsql_postgres.db_password
}

output "db_instance_name" {
  value =  module.cloudsql_postgres.db_instance_name
}

output "db_instance_connection_name" {
  value = module.cloudsql_postgres.db_instance_connection_name
}

output "db_public_ip_address" {
  value = module.cloudsql_postgres.db_public_ip_address
}

output "db_instance_server_ca_cert" {
  value = module.cloudsql_postgres.db_instance_server_ca_cert
}

output "db_instance_service_account_email_address" {
  value = module.cloudsql_postgres.db_instance_service_account_email_address
}
