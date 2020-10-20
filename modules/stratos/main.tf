resource "kubernetes_namespace" "stratos" {
  metadata {
    name = "stratos"
  }
}

data "template_file" "stratos_cert" {
  template = file("${path.module}/templates/cert.yml")

  vars = {
    stratos_domain = local.stratos_domain
    namespace     = kubernetes_namespace.stratos.metadata[0].name
  }
}

resource "k14s_kapp" "stratos_cert" {
  app = "stratos-cert"

  namespace = "default"

  config_yaml = data.template_file.stratos_cert.rendered
}

resource "random_password" "session_store_secret" {
  length = 24
  special = false
}

data "template_file" "stratos_config" {
  template = file("${path.module}/templates/${var.ingress}/values.yml")

  vars = {
    stratos_domain  = local.stratos_domain
    session_store_secret = random_password.session_store_secret.result
  }
}

resource "helm_release" "stratos" {
  depends_on = [k14s_kapp.stratos_cert]

  name       = "stratos"
  namespace  = kubernetes_namespace.stratos.metadata[0].name
  repository = "https://cloudfoundry.github.io/stratos"
  chart      = "console"
  version    = "4.2.0"

  values = [data.template_file.stratos_config.rendered]

  timeout    = 400
}
