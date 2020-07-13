variable "db_host" {
  description = "The hostname or IP address of the backing database for the service broker"
}

variable "db_name" {
  description = "Then name of the database within the database host"
  default = "servicebroker"
}

variable "db_password" {
  description = "The database username"
}

variable "db_user" {
  description = "The database password"
}

variable "db_port" {
 description = "The database port"
 default = "3306"
}

variable "db_ca_cert_file" {
  description = "The path to the CA certificate for the database"
}

variable "db_client_cert_file" {
  description = "The path to the client certificate for the database"
}

variable "db_client_key_file" {
  description = "The path to the private key for the database"
}

variable "registry_repository" {
 description = "Container image/artifact registry/repository name"
}

variable "registry_username" {
  description = "Container image/artifact registry/repository username"
  default = "admin"
}

variable "registry_password" {
  description = "Container image/artifact registry/repository password"
}

variable "container_image" {
  description = "Container image name for Pivotal Cloud Service Broker"
}

variable "container_tag" {
  description = "The specific tag/version of the container image for Pivotal Cloud Service Broker"
}

variable "cf_api_endpoint" {
  description = "The TAS4K8s API endpoint (e.g., api.tas.daf.ironleg.me)"
}

variable "cf_admin_username" {
  description = "The user name of the account used to administrate cf4k8s/tas4k8s"
  default = "admin"
}

variable "cf_admin_password" {
  description = "The password of the account used to administrate cf4k8s/tas4k8s"
}

variable "gcp_credentials" {
  description = "Service account credentials in JSON format"
}

variable "gcp_project" {
  description = "The GCP project that will host all managed services provisioned by the broker"
}
