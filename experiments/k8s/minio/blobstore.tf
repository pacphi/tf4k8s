module "minio_blobstore" {
  source = "../../../modules/minio"

  domain = var.domain
  kubeconfig_path = var.kubeconfig_path
}

variable "domain" {
  description = "The base domain wherein harbor.<domain> will be deployed"
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

output "minio_domain" {
  value = module.minio_blobstore.minio_domain
}

output "minio_accesskey_password" {
  value = module.minio_blobstore.minio_accesskey_password
}

output "minio_secretkey_password" {
  value = module.minio_blobstore.minio_secretkey_password
}
