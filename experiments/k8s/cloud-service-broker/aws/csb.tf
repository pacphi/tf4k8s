module "cloud-service-broker" {
  source = "../../../../modules/cloud-service-broker/aws"

  aws_credentials = var.aws_credentials

  db_host = var.db_host
  db_name = var.db_name
  db_user = var.db_user
  db_password = var.db_password
  db_port = var.db_port
  db_ca_cert_file = var.db_ca_cert_file
  db_client_cert_file = var.db_client_cert_file
  db_client_key_file = var.db_client_key_file

  registry_repository = var.registry_repository
  registry_username = var.registry_username
  registry_password = var.registry_password

  container_image = var.container_image
  container_tag = var.container_tag

  cf_api_endpoint = var.cf_api_endpoint
  cf_admin_username = var.cf_admin_username
  cf_admin_password = var.cf_admin_password
}

variable "db_host" {
  description = "The hostname or IP address of the backing database for the service broker"
}

variable "db_name" {
  description = "Then name of the database within the database host"
  default = "servicebroker"
}

variable "db_password" {
  description = "The database password"
}

variable "db_user" {
  description = "The database username"
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
  description = "Container image name for Cloud Service Broker"
}

variable "container_tag" {
  description = "The specific tag/version of the container image for Cloud Service Broker"
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

variable "aws_credentials" {
  description = "Path to AWS credentials file (e.g., ~/.aws/credentials)"
}
