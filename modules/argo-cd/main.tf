resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "kubernetes_namespace" "argo_rollouts" {
  metadata {
    name = "argo-rollouts"
  }
}

data "template_file" "argocd_config" {
  template = file("${path.module}/templates/${var.ingress}/argocd-values.yml")

  vars = {
    argocd_domain  = local.argocd_domain
    argocd_version = local.argocd_version
  }
}

data "template_file" "argo_rollouts_config" {
  template = file("${path.module}/templates/${var.ingress}/argo-rollouts-values.yml")

  vars = {
    argo_rollouts_version = local.argo_rollouts_version
  }
}

resource "helm_release" "argocd" {

  name       = "argocd"
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "2.10.0"

  values = [data.template_file.argocd_config.rendered]

  timeout    = 400
}

resource "helm_release" "argo_rollouts" {

  name       = "argo-rollouts"
  namespace  = kubernetes_namespace.argo_rollouts.metadata[0].name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-rollouts"
  version    = "0.3.8"

  values = [data.template_file.argo_rollouts_config.rendered]

  timeout    = 400
}