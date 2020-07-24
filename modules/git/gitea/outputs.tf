output "gitea_domain" {
  value = local.gitea_domain
}

output "gitea_inpod_postgres_secret" {
  value = random_password.inpod_postgres_secret.result
}