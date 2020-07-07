variable "authorized_networks" {
  description = "A list of authorized networks where each item in list has the following attributes [ name, value, expiration_time ].  The value in each item is a CIDR notation IPv4 or IPv6 address that is allowed to access this instance. Note that the value in each item must be set even if other two attributes are not for the whitelist to become active."
}

variable "database_version" {
  # MYSQL_5_6 or MYSQL_5_7
  description = "The database version to use. (@see https://www.terraform.io/docs/providers/google/r/sql_database_instance.html#database_version)"
}

variable "database_tier" {
  description = "The tier of compute used for the database instance"
}

variable "database_username" {
  description = "The name of the database instance default user"
}

variable "encryption_key_name" {
  description = "The full path to the encryption key used for the CMEK disk encryption"
}

variable "name" {
  description = "The name of the Cloud SQL resources"
}

variable "project" {
  description = "The project ID to manage the Cloud SQL resources"
}

variable "region" {
  description = "The region of the Cloud SQL resources"
}

variable "zone" {
  description = "The zone for the master instance, it should be something like: `a`, `c`"
}

variable "additional_databases" {
  # list(object({ project = string name = string charset = string collation = string instance = string }))
  description = "A list of databases to be created in your cluster"
}

variable "additional_users" {
  # list(object({ project = string name = string password = string host = string instance = string }))
  description = "A list of users to be created in your cluster"
}

variable "service_account_credentials" {
  description = "Path to service account credentials file in JSON format"
}
