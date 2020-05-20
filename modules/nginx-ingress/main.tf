resource "kubernetes_namespace" "nginx" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "nginx-ingress" {

  name       = "nginx"
  namespace  = kubernetes_namespace.nginx.metadata[0].name
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "nginx-ingress"
  version    = "1.36.3"

  # For additional configuration  options @see https://github.com/helm/charts/tree/master/stable/nginx-ingress#configuration

  set {
    name = "rbac.create"
    value = true
  }

  set {
    name  = "controller.publishService.enabled"
    value = "true"
  }

}
