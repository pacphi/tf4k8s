resource "helm_release" "fluentbit" {
  create_namespace = true

  name       = "fluent-bit"
  namespace  = var.namespace
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "fluent-bit"
  version    = "2.8.16"

  set {
    name = "backend.type"
    value = "es"
  }

  set {
    name = "backend.es.host"
    value = "elasticsearch-master"
  }

}

