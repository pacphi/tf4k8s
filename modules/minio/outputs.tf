output "minio_domain" {
  value = local.minio_domain
}

output "minio_accesskey_password" {
  value = random_password.accesskey_password.result
}

output "minio_secretkey_password" {
  value = random_password.secretkey_password.result
}