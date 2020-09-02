module "tsmgr" {
  source = "../../../modules/tsmgr"

  domain = "tsm.${var.domain}"
  ingress = var.ingress

  registry_domain = var.registry_domain
  registry_username = var.registry_username
  registry_password = var.registry_password
  tsmgr_images_prefix = var.tsmgr_images_prefix
  si_images_prefix = var.si_images_prefix
  s3_endpoint = var.s3_endpoint
  s3_bucket_name = var.s3_bucket_name
  s3_access_key = var.s3_access_key
  s3_secret_key = var.s3_secret_key
  cf_api_endpoint = var.cf_api_endpoint
  cf_admin_username = var.cf_admin_username
  cf_admin_password = var.cf_admin_password

  chart_path = var.chart_path
  kubeconfig_path = var.kubeconfig_path
}

variable "domain" {
  description = "The base domain wherein tsmgr.<domain> will be deployed"
}

variable "ingress" {
  description = "Used to specify which Ingress controller should serve a particular Ingress object.  Choices are: [ contour, nginx ]."
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

variable "chart_path" {
  description = "The path to the Tanzu Service Manager chart release"
  default = "/tmp/tsmgr"
}

variable "registry_domain" {
  description = "Container image/artifact registry/repository domain"
}

variable "registry_username" {
  description = "Container image/artifact registry/repository username"
  default = "admin"
}

variable "registry_password" {
  description = "Container image/artifact registry/repository password"
}

variable "tsmgr_images_prefix" {
  description = "Container image/artifact registry/repository name for Tanzu Service Manager images"
  default = "tanzu-service-manager"
}

variable "si_images_prefix" {
  description = "Container image/artifact registry/repository name for Tanzu Service Manager hosted service instance images"
  default = "tanzu-service-manager-si"
}

variable "s3_bucket_name" {
  description = "The name of an S3-compatible blobstore storage bucket"
  default = "tanzu-service-manager-offerings"
}

variable "s3_endpoint" {
  description = "The domain name of an S3-compatible service instance"
}

variable "s3_access_key" {
  description = "The access key used to authenticate to the S3-compatible service instance"
}

variable "s3_secret_key" {
  description = "The secret key used to authenticate to the S3-compatible service instance"
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
