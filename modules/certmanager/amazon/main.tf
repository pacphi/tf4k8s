resource "kubernetes_namespace" "certmanager" {
  metadata {
    name = "cert-manager"

    labels = {
      "certmanager.k8s.io/disable-validation" = true
    }
  }

}

resource "kubernetes_secret" "aws_client_secret" {
  metadata {
    name = "route53-credentials-secret"
    namespace = kubernetes_namespace.certmanager.metadata[0].name
  }

  data = {
    "secret-access-key" = var.secret_key
  }
}

data "template_file" "issuer_config" {
  template = file("${path.module}/templates/cluster-issuer.tpl")

  vars = {
    region       = var.region
    accessKeyId  = var.access_key
    hostedZoneId = var.hosted_zone_id
    acmeEmail    = var.acme_email
    domain       = var.domain
    namespace    = kubernetes_namespace.certmanager.metadata[0].name
  }
}

resource "k14s_kapp" "clusterissuer" {
  app = "certmanager-cluster-issuer"

  namespace = "default"

  config_yaml = data.template_file.issuer_config.rendered

  depends_on = [
    kubernetes_secret.aws_client_secret,
    helm_release.certmanager
  ]
}

resource "helm_release" "certmanager" {

  name       = "certifier"
  namespace  = kubernetes_namespace.certmanager.metadata[0].name
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.5.4"

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

}
