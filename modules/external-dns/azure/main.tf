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
  version    = "5.0.0"

  # For additional configuration options @see https://github.com/bitnami/charts/blob/master/bitnami/external-dns/values.yaml#L128

  set {
    name = "provider"
    value = "azure"
  }

  set {
    name = "azure.cloud"
    value = "AzurePublicCloud"
  }

  set {
    name  = "azure.resourceGroup"
    value = var.resource_group_name
  }

  set_sensitive {
    name = "azure.aadClientId"
    value = var.az_client_id
  }

  set_sensitive {
    name = "azure.aadClientSecret"
    value = var.az_client_secret
  }

  set_sensitive {
    name  = "azure.tenantId"
    value = var.az_tenant_id
  }

  set_sensitive {
    name  = "azure.subscriptionId"
    value = var.az_subscription_id
  }

  values = [ "\"domainFilters\" : [ \"${var.domain_filter}\" ]" ]
}