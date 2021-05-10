resource "kubernetes_namespace" "traefik" {
  metadata {
    name = "traefik"
  }
}

data "template_file" "traefik_config" {
  template = file("${path.module}/templates/values.tpl")

  vars = {
    traefik_log_level = var.traefik_log_level
  }
}

resource "helm_release" "traefik" {

  name       = "traefik"
  namespace  = kubernetes_namespace.traefik.metadata[0].name
  repository = "https://helm.traefik.io/traefik"
  chart      = "traefik"
  version    = "9.19.0"

  values = [data.template_file.traefik_config.rendered]

}
