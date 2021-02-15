resource "kubernetes_namespace" "loki_stack" {
  metadata {
    name = "loki-stack"
  }
}

data "template_file" "loki_stack_cert" {
  template = file("${path.module}/templates/cert.tpl")

  vars = {
    grafana_domain = local.grafana_domain
    namespace     = kubernetes_namespace.loki_stack.metadata[0].name
  }
}

resource "k14s_kapp" "loki_stack_cert" {
  app = "loki-stack-cert"

  namespace = "default"

  config_yaml = data.template_file.loki_stack_cert.rendered
}

resource "random_password" "admin_password" {
  length = 16
  special = false
}

resource "helm_release" "loki_stack" {
  depends_on = [k14s_kapp.loki_stack_cert]

  name       = "loki-stack"
  namespace  = kubernetes_namespace.loki_stack.metadata[0].name
  repository = "https://grafana.github.io/helm-charts "
  chart      = "loki-stack"
  version    = "2.3.1"

  set {
    name = "fluent-bit.enabled"
    value = true
  }

  set {
    name = "grafana.enabled"
    value = false
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

data "template_file" "grafana_config" {
  template = file("${path.module}/templates/${var.ingress}/values.tpl")

  vars = {
    grafana_domain  = local.grafana_domain
    admin_password = random_password.admin_password.result
  }
}

resource "helm_release" "grafana" {
  depends_on = [helm_release.loki_stack]

  name       = "grafana"
  namespace  = kubernetes_namespace.loki_stack.metadata[0].name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "grafana"
  version    = "3.3.0"

  values = [data.template_file.grafana_config.rendered]

  timeout    = 500
}