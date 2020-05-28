output "sys_domain" {
  description = "Domain where system components like uaa, routesync, log-cache and metric-proxy are running (e.g., *.sys.lab.cloudmonk.me)"
  value = local.system_domain
}

output "app_domain" {
  description = "Domain where applications are running (e.g., *.apps.lab.cloudmonk.me)"
  value = local.app_domain
}

output "tas_api_endpoint" {
  description = "The Tanzu Application Service API endpoint that you'll target with cf api {endpoint} (e.g., api.sys.lab.cloudmonk.me)"
  value = "api.${local.system_domain}"
}

output "tas_admin_username" {
  description = "The Tanzu Application Service cluster's administrator user name"
  value = "admin"
}

output "tas_admin_password" {
  description = "The Tanzu Application Service cluster's administrator password"
  value = random_password.gen.result
}