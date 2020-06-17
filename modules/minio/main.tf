resource "kubernetes_namespace" "minio" {
  metadata {
    name = "minio"
  }
}

data "template_file" "minio_cert" {
  template = file("${path.module}/templates/cert.yml")

  vars = {
    minio_domain = local.minio_domain
    namespace     = kubernetes_namespace.minio.metadata[0].name
  }
}

resource "k14s_kapp" "minio_cert" {
  app = "minio-cert"

  namespace = "default"

  config_yaml = data.template_file.minio_cert.rendered
}

resource "random_password" "accesskey_password" {
  length = 10
  special = false
}

resource "random_password" "secretkey_password" {
  length = 40
  special = false
}

data "template_file" "minio_config" {
  template = file("${path.module}/templates/${var.ingress}/values.yml")

  vars = {
    minio_domain  = local.minio_domain
    accesskey_password = random_password.accesskey_password.result
    secretkey_password = random_password.secretkey_password.result
  }
}

resource "helm_release" "minio" {
  depends_on = [k14s_kapp.minio_cert]

  name       = "minio"
  namespace  = kubernetes_namespace.minio.metadata[0].name
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "minio"
  version    = "5.0.29"

  values = [data.template_file.minio_config.rendered]

  timeout    = 400
}
