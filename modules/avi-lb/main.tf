resource "kubernetes_namespace" "avi" {
  metadata {
    name = "avi-system"
  }
}

data "template_file" "avi_config" {
  template = file("${path.module}/templates/values.tpl")

  vars = {
    avi_hostname = var.avi_hostname
    avi_cluster_name = var.avi_cluster_name
    avi_cni_plugin = var.avi_cni_plugin
    avi_controller_username = var.avi_controller_username
    avi_controller_password = var.avi_controller_password
  }
}

resource "helm_release" "avi_operator" {

  name       = "ako-operator"
  namespace  = kubernetes_namespace.avi.metadata[0].name
  repository = "https://avinetworks.github.io/avi-helm-charts/charts/stable/ako"
  chart      = "ako"
  version    = "1.3.1"

  # For additional configuration options @see https://github.com/avinetworks/avi-helm-charts/blob/master/docs/AKO/install/operator.md#parameters

  values = [data.template_file.avi_config.rendered]

}
