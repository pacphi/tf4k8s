resource "kubernetes_namespace" "concourse" {
  metadata {
    name = "concourse"
  }
}

resource "random_password" "concourse_password" {
  length = 10
  special = false
}

data "template_file" "concourse_cert" {
  template = file("${path.module}/templates/cert.tpl")

  vars = {
    concourse_domain = local.concourse_domain
    namespace     = kubernetes_namespace.concourse.metadata[0].name
  }
}

resource "k14s_kapp" "concourse_cert" {
  app = "concourse-cert"

  namespace = "default"

  config_yaml = data.template_file.concourse_cert.rendered
}


data "template_file" "concourse_config" {
  template = file("${path.module}/templates/${var.ingress}/values.tpl")

  vars = {
    concourse_domain  = local.concourse_domain
    concourse_username = var.concourse_username
    concourse_password = random_password.concourse_password.result
  }
}

resource "helm_release" "concourse" {
  depends_on = [k14s_kapp.concourse_cert]

  name       = "concourse"
  namespace  = kubernetes_namespace.concourse.metadata[0].name
  repository = "https://concourse-charts.storage.googleapis.com"
  chart      = "concourse"
  version    = "15.1.0"

  values = [data.template_file.concourse_config.rendered]

  timeout    = 400
}
