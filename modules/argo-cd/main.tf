resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

data "template_file" "argocd_config" {
  template = file("${path.module}/templates/values.yml")

  vars = {
    argocd_domain  = local.argocd_domain
  }
}

resource "helm_release" "argocd" {

  name       = "argocd"
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "2.3.5"

  values = [data.template_file.argocd_config.rendered]

  timeout    = 400
}
