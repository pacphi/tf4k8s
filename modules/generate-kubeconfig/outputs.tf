output "content" {
  value = data.template_file.kubeconfig.rendered
}

output "path_to_kubeconfig" {
  value = local_file.kubeconfig.filename
}