resource "helm_release" "flagger" {

  name       = "flagger"
  namespace  = "projectcontour"
  repository = "https://flagger.app"
  chart      = "flagger"
  version    = "1.3.0"

  set {
    name = "meshProvider"
    value = "contour"
  }

  set {
    name = "ingressClass"
    value = "contour"
  }

  set {
    name = "prometheus.install"
    value = "true"
  }
}
