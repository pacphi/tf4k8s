output "content" {
  value = data.template_file.kubeconfig.rendered
}