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
  version    = "4.5.1"

  # For additional configuration options @see https://github.com/bitnami/charts/blob/master/bitnami/external-dns/values.yaml#L45

  set {
    name = "provider"
    value = "aws"
  }

  set {
    name = "aws.region"
    value = var.region
  }

  set_sensitive {
    name = "aws.credentials.secretKey"
    value = var.aws_secret_key
  }

  set_sensitive {
    name = "aws.credentials.accessKey"
    value = var.aws_access_key
  }

  values = [ "\"domainFilters\" : [ \"${var.domain_filter}\" ]" ]
}