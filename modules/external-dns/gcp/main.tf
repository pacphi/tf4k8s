resource "kubernetes_namespace" "external_dns" {
  metadata {
    name = "external-dns"
  }
}

resource "helm_release" "external_dns" {

  name       = "external-dns"
  namespace  = kubernetes_namespace.external_dns.metadata[0].name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  version    = "3.2.3"

  # For additional configuration options @see https://github.com/bitnami/charts/blob/master/bitnami/external-dns/values.yaml#L258

  set {
    name = "provider"
    value = "google"
  }

  set {
    name = "google.project"
    value = var.gcp_project
  }

  set_sensitive {
    name = "google.serviceAccountSecretKey"
    value = pathexpand(var.gcp_service_account_credentials)
  }
  
  values = [ "\"domainFilters\" : [ \"${var.domain_filter}\" ]" ]
}