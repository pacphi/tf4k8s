resource "kubernetes_namespace" "external_dns" {
  metadata {
    name = "external-dns"
  }
}

resource "kubernetes_secret" "external_dns" {
  metadata {
    namespace = kubernetes_namespace.external_dns.metadata[0].name
    name = "external-dns"
  }

  data = {
    "credentials.json" = file(pathexpand(var.gcp_service_account_credentials))
  }
}

resource "helm_release" "external_dns" {

  depends_on = [ kubernetes_secret.external_dns ]

  name       = "external-dns"
  namespace  = kubernetes_namespace.external_dns.metadata[0].name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  version    = "3.4.4"

  # For additional configuration options @see https://github.com/bitnami/charts/blob/master/bitnami/external-dns/values.yaml#L258
  # And special thanks to https://itsmetommy.com/2019/06/14/kubernetes-automated-dns-with-externaldns-on-gke/ for clarity

  set {
    name = "provider"
    value = "google"
  }

  set {
    name = "google.project"
    value = var.gcp_project
  }

  set_sensitive {
    name = "google.serviceAccountSecret"
    value = "external-dns"
  }

  set {
    name = "logLevel"
    value = "debug"
  }
  
  set {
    name = "txtPrefix"
    value = "txt"
  }

  values = [ "\"domainFilters\" : [ \"${var.domain_filter}\" ]" ]
}