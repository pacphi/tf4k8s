resource "helm_release" "metricbeat" {
  create_namespace = true

  name       = "metricbeat"
  namespace  = var.namespace
  repository = "https://Helm.elastic.co"
  chart      = "metricbeat"
  version    = "7.10.0"

}
