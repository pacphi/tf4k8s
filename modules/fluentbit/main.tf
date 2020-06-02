resource "k14s_kapp" "fluentbit" {
  app = "fluentbit"

  files = [
    "${path.module}/${var.ytt_lib_dir}/fluentbit/vendor/fluent-bit-service-account.yaml",
    "${path.module}/${var.ytt_lib_dir}/fluentbit/vendor/fluent-bit-role.yaml",
    "${path.module}/${var.ytt_lib_dir}/fluentbit/vendor/fluent-bit-role-binding.yaml",
    "${path.module}/${var.ytt_lib_dir}/fluentbit/vendor/output/elasticsearch/fluent-bit-configmap.yaml",
    "${path.module}/${var.ytt_lib_dir}/fluentbit/vendor/output/elasticsearch/fluent-bit-ds.yaml"
  ]

  namespace = var.namespace

  debug_logs = true

  deploy {
    raw_options = ["--dangerous-allow-empty-list-of-resources=true"]
  }
}
