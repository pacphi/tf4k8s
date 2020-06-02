resource "helm_release" "metricbeat" {
  create_namespace = true

  name       = "metrcibeat"
  namespace  = var.namespace
  repository = "https://Helm.elastic.co"
  chart      = "metricbeat"
  version    = "7.7.0"

}
