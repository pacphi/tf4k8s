resource "kubernetes_namespace" "certmanager" {
  metadata {
    name = "cert-manager"

    labels = {
      "certmanager.k8s.io/disable-validation" = true
    }
  }

}

resource "kubernetes_secret" "az_client_secret" {
  metadata {
    name = "azuredns-config"
    namespace = kubernetes_namespace.certmanager.metadata[0].name
  }

  data = {
    "client-secret" = var.az_client_secret
  }
}

data "template_file" "issuer_config" {
  template = file("${path.module}/templates/cluster-issuer.yml")

  vars = {
    clientId       = var.az_client_id
    subscriptionId = var.az_subscription_id
    tenantId       = var.az_tenant_id
    resourceGroup  = var.cluster_issuer_resource_group
    acmeEmail      = var.acme_email
    domain         = var.domain
    namespace    = kubernetes_namespace.certmanager.metadata[0].name
  }
}

resource "k14s_kapp" "clusterissuer" {
  app = "certmanager-cluster-issuer"

  namespace = "default"

  config_yaml = data.template_file.issuer_config.rendered

  depends_on = [
    kubernetes_secret.az_client_secret,
    helm_release.certmanager
  ]
}

resource "helm_release" "certmanager" {

  name       = "certifier"
  namespace  = kubernetes_namespace.certmanager.metadata[0].name
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.0.2"

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
