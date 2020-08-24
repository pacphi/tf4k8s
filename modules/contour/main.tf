data "http" "contour" {
  url = "https://raw.githubusercontent.com/projectcontour/contour/release-1.7/examples/render/contour.yaml"
}

resource "k14s_kapp" "contour" {
  app = "contour"

  namespace = "default"

  config_yaml = data.http.contour.body
}


