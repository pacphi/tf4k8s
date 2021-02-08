resource "kubernetes_namespace" "minio" {
  metadata {
    name = "minio"
  }
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

  name       = "minio"
  namespace  = kubernetes_namespace.minio.metadata[0].name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "minio"
  version    = "6.1.4"

  values = [data.template_file.minio_config.rendered]

  timeout    = 400
}
