locals {
  system_domain = var.domain
  app_domain = "apps.${var.domain}"
  postgres_instance_name = "pgsqlcfdb"
}