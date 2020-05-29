data "template_file" "kubeconfig" {
  template = file("${path.module}/templates/kubeconfig.tmpl")
  vars = {
    username = var.username
    cluster_name = var.cluster_name
    context_name = var.context_name
    server  = var.endpoint
    ca_cert = var.certificate_ca
    token   = var.token
  }
}

resource "local_file" "kubeconfig" {
    content     = data.template_file.kubeconfig.rendered
    filename = "${var.directory}/${var.filename}"
}