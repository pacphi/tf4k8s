variable "container_image" {
  description = "Container image name for Stratos"
  default = "splatform/stratos"
}

variable "container_tag" {
  description = "The specific tag/version of the container image for Stratos"
  default = "stable"
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

variable "cf_service_offering_name" {
  description = "The name of a service offering in the marketplace that will be used to create a PostgreSQL database instance"
  default = "csb-google-postgres"
}

variable "cf_service_offering_plan" {
  description = "The plan of a service offering in the marketplace that will be used to create a PostgreSQL database instance"
  default = "small"
}

variable "cf_service_name" {
  description = "The name of the service that will be bound to Stratos"
  default = "console_db"
}