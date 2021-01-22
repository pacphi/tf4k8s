resource "kubernetes_namespace" "tkgi_logsink" {
  metadata {
    name = "tkgi-logsink"
  }
}

data "template_file" "tkgi_logsink_install" {
  template = file("${path.module}/templates/cluster-log-sink.yml")

  vars = {
    name = var.tkgi_cluster_name
    hostname = var.sink_hostname
    portl = var.sink_port
    insecure_skip_verify = var.sink_insecure_skip_verify
  }
}

resource "k14s_kapp" "tkgi_logsink_install" {
  app = "tkgi-logsink"
  namespace = kubernetes_namespace.tkgi_logsink.metadata[0].name

  config_yaml = data.template_file.tkgi_logsink_install.rendered
}