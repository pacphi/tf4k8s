resource "helm_release" "elasticsearch" {
  create_namespace = true

  name       = "elasticsearch"
  namespace  = var.namespace
  repository = "https://Helm.elastic.co"
  chart      = "elasticsearch"
  version    = "7.9.2"

  # Warning this combination of settings could consume quite a bit of memory
  set {
    name = "master.persistence.enabled"
    value = false
  }

  set {
    name = "data.persistence.enabled"
    value = false
  }
}
