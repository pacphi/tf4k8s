data "http" "contour_operator" {
  url = "https://raw.githubusercontent.com/projectcontour/contour-operator/release-1.15/examples/operator/operator.yaml"
}

data "http" "contour" {
  url = "https://raw.githubusercontent.com/projectcontour/contour-operator/release-1.15/examples/contour/contour.yaml"
}

resource "k14s_kapp" "contour_operator" {
  app = "contour-operator"

  namespace = "default"

  config_yaml = data.http.contour_operator.body
}

resource "k14s_kapp" "contour" {
  app = "contour"

  namespace = "default"

  config_yaml = data.http.contour.body

  depends_on = [
    k14s_kapp.contour_operator
  ]
}
