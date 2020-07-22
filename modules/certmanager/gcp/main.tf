resource "kubernetes_namespace" "certmanager" {
  metadata {
    name = "cert-manager"

    labels = {
      "certmanager.k8s.io/disable-validation" = true
    }
  }

}

resource "kubernetes_secret" "certmanager" {
  metadata {
    namespace = kubernetes_namespace.certmanager.metadata[0].name
    name = "cert-manager"
  }

  data = {
    "credentials.json" = file(pathexpand(var.gcp_service_account_credentials))
  }
}


data "template_file" "issuer_config" {
  template = file("${path.module}/templates/cluster-issuer.yml")

  vars = {
    project      = var.project
    acmeEmail    = var.acme_email
    domain       = var.domain
    namespace    = kubernetes_namespace.certmanager.metadata[0].name
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
  version    = "v0.15.1"

  set {
    name = "installCRDs"
    value = true
  }

  set {
    name  = "ingressShim.defaultIssuerName"
    value = "letsencrypt-prod"
  }

  set {
    name  = "ingressShim.defaultIssuerKind"
    value = "ClusterIssuer"
  }

  set {
    name  = "ingressShim.defaultACMEChallengeType"
    value = "dns01"
  }

  set {
    name  = "ingressShim.defaultACMEDNS01ChallengeProvider"
    value = "clouddns"
  }

}
