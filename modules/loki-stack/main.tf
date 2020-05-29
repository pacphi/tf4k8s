resource "kubernetes_namespace" "loki_stack" {
  metadata {
    name = "loki-stack"
  }
}

data "template_file" "loki_stack_cert" {
  template = file("${path.module}/templates/cert.yml")

  vars = {
    grafana_domain = local.grafana_domain
    prometheus_domain = local.prometheus_domain
    namespace     = kubernetes_namespace.loki_stack.metadata[0].name
  }
}

resource "k14s_kapp" "loki_stack_cert" {
  app = "loki-stack-cert"

  namespace = "default"

  config_yaml = data.template_file.loki_stack_cert.rendered

  deploy {
    raw_options = ["--dangerous-allow-empty-list-of-resources=true"]
  }
}

resource "helm_release" "loki_stack" {
  depends_on = [k14s_kapp.loki_stack_cert]

  name       = "loki-stack"
  namespace  = kubernetes_namespace.loki_stack.metadata[0].name
  repository = "https://grafana.github.io/loki/charts"
  chart      = "loki-stack"
  version    = "0.37.2"

  set {
    name = "fluent-bit.enabled"
    value = true
  }

  set {
    name = "grafana.enabled"
    value = true
  }

  set {
    name = "promtail.enabled"
    value = false
  }

  set {
    name = "prometheus.enabled"
    value = true
  }

  set {
    name = "prometheus.alertmanager.persistentVolume.enabled"
    value = false
  }

  set {
    name = "prometheus.server.persistentVolume.enabled"
    value = false
  }

  timeout    = 500
}
