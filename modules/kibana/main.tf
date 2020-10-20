data "template_file" "kibana_cert" {
  template = file("${path.module}/templates/cert.yml")

  vars = {
    kibana_domain = local.kibana_domain
    namespace     = var.namespace
  }

}

resource "k14s_kapp" "kibana_cert" {
  app = "kibana-cert"

  namespace = "default"

  config_yaml = data.template_file.kibana_cert.rendered

  debug_logs = true
}

data "template_file" "kibana_config" {
  template = file("${path.module}/templates/${var.ingress}/values.yml")

  vars = {
    kibana_domain  = local.kibana_domain
  }
}

resource "helm_release" "kibana" {
  depends_on = [k14s_kapp.kibana_cert]

  create_namespace = true
  name       = "kibana"
  namespace  = var.namespace
  repository = "https://Helm.elastic.co"
  chart      = "kibana"
  version    = "7.9.2"

  values = [data.template_file.kibana_config.rendered]
}
