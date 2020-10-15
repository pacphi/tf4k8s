locals {
  system_domain = var.domain
  app_domain = "apps.${var.domain}"
  postgres_instance_name = "pgsqlcfdb"
  ytt_lib_dir = var.ytt_lib_dir != "../../ytt-libs" ? var.ytt_lib_dir : "${path.module}/${var.ytt_lib_dir}"
}