// @see https://cert-manager.io/docs/configuration/venafi

resource "kubernetes_namespace" "certmanager" {
  metadata {
    name = "cert-manager"
  }

}

resource "kubernetes_secret" "certmanager" {
  metadata {
    namespace = kubernetes_namespace.certmanager.metadata[0].name
    name = "tpp-secret"
  }

  data = {
    "access-token" = var.venafi_tpp_access_token
  }
}

data "template_file" "issuer_config" {
  template = file("${path.module}/templates/cluster-issuer.tpl")

  vars = {
    venafi_policy_zone_guid = var.venafi_policy_zone_guid
    namespace = kubernetes_namespace.certmanager.metadata[0].name
  }

  depends_on = [ kubernetes_secret.certmanager ]
}

resource "k14s_kapp" "clusterissuer" {
  app = "certmanager-cluster-issuer"

  namespace = "default"

  config_yaml = data.template_file.issuer_config.rendered

  depends_on = [helm_release.certmanager]
}

resource "helm_release" "certmanager" {

  name       = "certifier"
  namespace  = kubernetes_namespace.certmanager.metadata[0].name
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.3.1"

  set {
    name = "installCRDs"
    value = true
  }

  set {
    name  = "ingressShim.defaultIssuerKind"
    value = "ClusterIssuer"
  }

}
