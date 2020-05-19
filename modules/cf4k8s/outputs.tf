output "sys_domain" {
  value = local.sys_domain
}

output "app_domain" {
  value = local.app_domain
}

output "cf_api_endpoint" {
  value = "api.${local.sys_domain}"
}

output "cf_admin_username" {
  value = "admin"
}

output "cf_admin_password" {
  value = random_password.gen.result
}