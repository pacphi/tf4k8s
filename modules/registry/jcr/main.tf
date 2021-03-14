resource "kubernetes_namespace" "jcr" {
  metadata {
    name = "jcr"
  }
}

resource "random_password" "postgres_password" {
  length = 24
  special = false
}

data "template_file" "jcr_cert" {
  template = file("${path.module}/templates/cert.tpl")

  vars = {
    jcr_domain = local.jcr_domain
    namespace     = kubernetes_namespace.jcr.metadata[0].name
  }
}

resource "k14s_kapp" "jcr_cert" {
  app = "jcr-cert"

  namespace = "default"

  config_yaml = data.template_file.jcr_cert.rendered
}

data "template_file" "jcr_config" {
  template = file("${path.module}/templates/${var.ingress}/values.tpl")

  vars = {
    jcr_domain  = local.jcr_domain
    jcr_postgresql_password = random_password.postgres_password.result
  }
}

resource "helm_release" "jcr" {
  depends_on = [k14s_kapp.jcr_cert]

  name       = "jcr"
  namespace  = kubernetes_namespace.jcr.metadata[0].name
  repository = "https://charts.jfrog.io"
  chart      = "artifactory-jcr"
  version    = "3.5.1"

  values = [data.template_file.jcr_config.rendered]

  timeout    = 400
}
