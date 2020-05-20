module "common" {
  source = "../common"

  namespace = var.namespace
  domain_filter = var.domain_filter
  zone_id_filter = var.zone_id_filter
  dns_provider = "google"
  enable_istio = var.enable_istio
  kubeconfig_path = var.kubeconfig_path
  ytt_lib_dir = var.ytt_lib_dir
}