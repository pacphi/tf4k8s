output "grafana_username" {
  value = "admin"
}

output "grafana_password" {
  value = random_password.admin_password.result
}

output "grafana_domain" {
  value = local.grafana_domain
}