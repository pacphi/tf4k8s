resource "kubernetes_namespace" "wavefront" {
  metadata {
    name = "wavefront"
  }
}

resource "helm_release" "wavefront" {

  name       = "wavefront"
  namespace  = kubernetes_namespace.wavefront.metadata[0].name
  repository = "https://raw.githubusercontent.com/wavefrontHQ/wavefront-operator/master/install/"
  chart      = "wavefront-operator"
  version    = "0.9.5"

  set {
    name = "wavefront.url"
    value = var.wavefront_url
  }

  set {
    name = "wavefront.token"
    value = var.wavefront_api_token
  }

  set {
    name = "clusterName"
    value = var.cluster_name
  }

}
