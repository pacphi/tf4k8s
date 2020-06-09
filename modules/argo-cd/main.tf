resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

data "template_file" "argocd_cert" {
  template = file("${path.module}/templates/cert.yml")

  vars = {
    argocd_domain = local.argocd_domain
    namespace     = kubernetes_namespace.argocd.metadata[0].name
  }
}

resource "k14s_kapp" "argocd_cert" {
  app = "argocd-cert"

  namespace = "default"

  config_yaml = data.template_file.argocd_cert.rendered

  deploy {
    raw_options = ["--dangerous-allow-empty-list-of-resources=true"]
  }
}

data "template_file" "argocd_config" {
  template = file("${path.module}/templates/values.yml")

  vars = {
    argocd_domain  = local.argocd_domain
  }
}

resource "helm_release" "argocd" {
  depends_on = [k14s_kapp.argocd_cert]

  name       = "argocd"
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "2.3.5"

  values = [data.template_file.argocd_config.rendered]

  timeout    = 400
}
