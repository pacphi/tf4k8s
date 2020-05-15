output "harbor_domain" {
  value = local.harbor_domain
}

output "harbor_admin_username" {
  value = "admin"
}

output "harbor_admin_password" {
  value = random_password.admin_password.result
}