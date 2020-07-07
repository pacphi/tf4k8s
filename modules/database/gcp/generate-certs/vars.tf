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

variable "service_account_credentials" {
  description = "Path to service account credentials file in JSON format"
}
