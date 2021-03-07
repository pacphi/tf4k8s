module "gcp_blobstore" {
  source        = "SweetOps/storage-bucket/google"

  project       = var.gcp_project
  location      = var.gcp_region
  name          = var.gcp_bucket_name
  environment   = var.environment
  namespace     = var.namespace
  force_destroy = true
}

variable "gcp_project" {
  description = "A Google Cloud Platform project id"
  sensitive = true
}

variable "gcp_region" {
  description = "A valid Google Cloud Platform region"
  default = "us-west1"
}

variable "gcp_bucket_name" {
  description = "Name of the bucket"
}

variable "environment" {
  description = "Environment (e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT')"
  default = "dev"
}

variable "namespace" {
  description = "Namespace, which could be your organization name or abbreviation (e.g. 'eg' or 'cp')"
}

variable "gcp_service_account_credentials" {
  description = "Path to service account credentials file in JSON format"
}

provider "google" {
  version     = ">=3.21.0"
  credentials = file(var.gcp_service_account_credentials)
  project     = var.gcp_project
  region      = var.gcp_region
}