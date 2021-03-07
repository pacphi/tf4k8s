variable "domain" {}

variable "registry_domain" {}

variable "registry_username" {
  sensitive = true
}

variable "registry_password" {
  sensitive = true
}

variable "tsmgr_images_prefix" {
  default = "tanzu-service-manager"
}

variable "si_images_prefix" {
  default = "tanzu-service-manager-si"
}

variable "s3_bucket_name" {
  default = "tanzu-service-manager-offerings"
}

variable "s3_endpoint" {}

variable "s3_access_key" {
  sensitive = true
}

variable "s3_secret_key" {
  sensitive = true
}

variable "cf_api_endpoint" {}

variable "cf_admin_username" {
  sensitive = true
}

variable "cf_admin_password" {
  sensitive = true
}

variable "ingress" {
  description = "Used to specify which Ingress controller should serve a particular Ingress object.  Choices are: [ contour, nginx ]."
}

variable "kubeconfig_path" {}

variable "chart_path" {}