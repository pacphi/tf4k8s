data "k14s_ytt" "externaldns" {
  files = [
    "${var.ytt_lib_dir}/external-dns"
  ]

  values = merge({
    namespace = var.namespace
    domainFilter = var.domain_filter
    provider = var.dns_provider
    zoneIdFilter = var.zone_id_filter
    enableIstio = var.enable_istio
  }, var.values)

  ignore_unknown_comments = true
}

resource "k14s_kapp" "externaldns" {

  app = "externaldns"
  namespace = "default"

  config_yaml = data.k14s_ytt.externaldns.result

  // Sleep before destroying so external-dns has time to clean up records
  provisioner "local-exec" {
    when    = destroy
    command = "sleep 90"
  }
}

