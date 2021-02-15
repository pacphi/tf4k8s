resource "kubernetes_namespace" "gitea" {
  metadata {
    name = "gitea"
  }
}

data "template_file" "gitea_cert" {
  template = file("${path.module}/templates/cert.tpl")

  vars = {
    gitea_domain = local.gitea_domain
    namespace     = kubernetes_namespace.gitea.metadata[0].name
  }
}

resource "k14s_kapp" "gitea_cert" {
  app = "gitea-cert"

  namespace = "default"

  config_yaml = data.template_file.gitea_cert.rendered
}

resource "random_password" "inpod_postgres_secret" {
  length = 24
  special = false
}

data "template_file" "gitea_config" {
  template = file("${path.module}/templates/${var.ingress}/values.tpl")

  vars = {
    gitea_domain  = local.gitea_domain
    inpod_postgres_secret = random_password.inpod_postgres_secret.result
    persistence_enabled = var.persistence_enabled
    persistence_storageclass = var.persistence_storageclass
  }
}

resource "helm_release" "gitea" {
  depends_on = [k14s_kapp.gitea_cert]

  name       = "gitea"
  namespace  = kubernetes_namespace.gitea.metadata[0].name
  repository = "https://keyporttech.github.io/helm-charts/"
  chart      = "gitea"
  version    = "0.2.10"

  values = [data.template_file.gitea_config.rendered]

  timeout    = 400
}
