locals {
  tmp_dir = "/tmp/cf4k8s"
  cf4k8s_config = "${local.tmp_dir}/cf-values.yml"
  system_domain = "${var.domain}"
  app_domain = "apps.${var.domain}"
}