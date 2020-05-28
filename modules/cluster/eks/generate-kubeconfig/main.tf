data "template_file" "kubeconfig" {
  template = file("${path.module}/templates/kubeconfig.tmpl")
  vars = {
    server  = var.endpoint
    ca_cert = var.certificate_ca
    token   = var.token
  }
}