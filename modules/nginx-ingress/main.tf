resource "kubernetes_namespace" "nginx" {
  metadata {
    name = "nginx-ingress"
  }
}

data "template_file" "nginx_config" {
  template = file("${path.module}/templates/values.yml")

  vars = {
    extraArgsKey  = var.extra_args_key
    extraArgsValue  = var.extra_args_value
  }
}

resource "helm_release" "nginx-ingress" {

  name       = "nginx"
  namespace  = kubernetes_namespace.nginx.metadata[0].name
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "nginx-ingress"
  version    = "1.39.1"

  # For additional configuration  options @see https://github.com/helm/charts/tree/master/stable/nginx-ingress#configuration

  set {
    name = "rbac.create"
    value = true
  }

  set {
    name  = "controller.publishService.enabled"
    value = "true"
  }

  values = [data.template_file.nginx_config.rendered]

}
