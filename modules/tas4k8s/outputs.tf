output "sys_domain" {
  value = local.system_domain
}

output "app_domain" {
  value = local.app_domain
}

output "tas_api_endpoint" {
  value = "api.${local.system_domain}"
}

output "tas_admin_username" {
  value = "admin"
}

output "tas_admin_password" {
  value = random_password.gen.result
}