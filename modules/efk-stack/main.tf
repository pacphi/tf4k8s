resource "kubernetes_namespace" "efk_stack" {
  metadata {
    name = "efk-stack"
  }
}

resource "helm_release" "elasticsearch" {

  name       = "elasticsearch"
  namespace  = kubernetes_namespace.efk_stack.metadata[0].name
  repository = "https://Helm.elastic.co"
  chart      = "elasticsearch"
  version    = "7.7.0"

  # Warning this combination of settings could consume quite a bit of memory
  set {
    name = "master.persistence.enabled"
    value = false
  }

  set {
    name = "data.persistence.enabled"
    value = false
  }
}

data "template_file" "kibana_cert" {
  template = file("${path.module}/templates/cert.yml")

  vars = {
    kibana_domain = local.kibana_domain
    namespace     = kubernetes_namespace.efk_stack.metadata[0].name
  }

  depends_on = [helm_release.elasticsearch]
}

resource "k14s_kapp" "kibana_cert" {
  app = "kibana-cert"

  namespace = "default"

  config_yaml = data.template_file.kibana_cert.rendered

  debug_logs = true

  deploy {
    raw_options = ["--dangerous-allow-empty-list-of-resources=true"]
  }

  depends_on = [helm_release.elasticsearch]
}

data "template_file" "kibana_config" {
  template = file("${path.module}/templates/values.yml")

  vars = {
    kibana_domain  = local.kibana_domain
  }
}

resource "helm_release" "kibana" {
  depends_on = [k14s_kapp.kibana_cert]

  name       = "kibana"
  namespace  = kubernetes_namespace.efk_stack.metadata[0].name
  repository = "https://Helm.elastic.co"
  chart      = "kibana"
  version    = "7.7.0"

  set {
    name = "env.ELASTICSEARCH_URL"
    value = "http://elasticsearch-client:9200"
  }

  values = [data.template_file.kibana_config.rendered]

}

resource "k14s_kapp" "fluentbit" {
  app = "fluentbit"

  files = [
    "${path.module}/${var.ytt_lib_dir}/fluentbit/vendor/fluent-bit-service-account.yaml",
    "${path.module}/${var.ytt_lib_dir}/fluentbit/vendor/fluent-bit-role.yaml",
    "${path.module}/${var.ytt_lib_dir}/fluentbit/vendor/fluent-bit-role-binding.yaml",
    "${path.module}/${var.ytt_lib_dir}/fluentbit/vendor/output/elasticsearch/fluent-bit-configmap.yaml",
    "${path.module}/${var.ytt_lib_dir}/fluentbit/vendor/output/elasticsearch/fluent-bit-ds.yaml"
  ]
  namespace = kubernetes_namespace.efk_stack.metadata[0].name

  config_yaml = data.template_file.kibana_cert.rendered

  debug_logs = true

  deploy {
    raw_options = ["--dangerous-allow-empty-list-of-resources=true"]
  }

  depends_on = [
    helm_release.kibana
  ]
}

