resource "helm_release" "fluentbit" {
  create_namespace = true

  name       = "fluent-bit"
  namespace  = var.namespace
  repository = "https://fluent.github.io/helm-charts"
  chart      = "fluent-bit"
  version    = "0.7.13"

}
