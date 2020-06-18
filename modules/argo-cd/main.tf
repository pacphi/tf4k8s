resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

data "template_file" "argocd_config" {
  template = file("${path.module}/templates/${var.ingress}/values.yml")

  vars = {
    argocd_domain  = local.argocd_domain
    argocd_version = local.argocd_version
  }
}

resource "helm_release" "argocd" {

  name       = "argocd"
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "2.3.6"

  values = [data.template_file.argocd_config.rendered]

  timeout    = 400
}
