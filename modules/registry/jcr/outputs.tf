output "jcr_domain" {
  value = local.jcr_domain
}

output "jcr_admin_username" {
  value = "admin"
}

output "jcr_admin_password" {
  value = "password"
}

output "jcr_postgresql_password" {
  value = random_password.postgres_password.result
}