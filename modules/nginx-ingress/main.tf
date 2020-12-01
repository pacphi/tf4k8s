locals {
  hasKeyAndValue = length(trimspace(var.extra_args_key)) > 0 && length(trimspace(var.extra_args_value)) > 0
  hasValue = length(trimspace(var.extra_args_key)) == 0 && length(trimspace(var.extra_args_value)) > 0
  interimExpression = local.hasKeyAndValue ? indent(4, "\n${var.extra_args_key}: ${var.extra_args_value}") : "{}"
  extraArgsExpression = local.interimExpression == "{}" && local.hasValue ? indent(4, "\n${var.extra_args_value}") : local.interimExpression
}

resource "kubernetes_namespace" "nginx" {
  metadata {
    name = "nginx-ingress"
  }
}

data "template_file" "nginx_config" {
  template = file("${path.module}/templates/values.yml")

  vars = {
    extraArgsExpression  = local.extraArgsExpression
  }
}

resource "helm_release" "nginx-ingress" {

  name       = "nginx"
  namespace  = kubernetes_namespace.nginx.metadata[0].name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
  version    = "6.0.1"

  # For additional configuration  options @see https://github.com/helm/charts/tree/master/stable/nginx-ingress#configuration

  set {
    name = "rbac.create"
    value = true
  }

  set {
    name  = "publishService.enabled"
    value = "true"
  }

  values = [data.template_file.nginx_config.rendered]

}
