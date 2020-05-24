resource "kubernetes_namespace" "external_dns" {
  metadata {
    name = var.namespace
  }
}

data "local_file" "external_dns_config" {
  filename = "${path.module}/vendor/values-production.yaml"
}

resource "helm_release" "external_dns" {

  name       = "external-dns"
  namespace  = kubernetes_namespace.external_dns.metadata[0].name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  version    = "3.0.2"

  # For additional configuration  options @see https://github.com/bitnami/charts/blob/master/bitnami/external-dns/values.yaml#L128

  set {
    name = "azure.cloud"
    value = "AzurePublicCloud"
  }

  set {
    name  = "azure.resourceGroup"
    value = var.resource_group_name
  }

  set {
    name = "domainFilters"
    value = [ var.domain_filter ]
  }

  set_sensitive {
    name  = "azure.tenantId"
    value = var.az_tenant_id
  }

  set_sensitive {
    name  = "azure.subscriptionId"
    value = var.az_subscription_id
  }

  # @see https://www.terraform.io/docs/providers/helm/r/release.html#values
  values = data.local_file.external_dns_config.content
}