output "concourse_domain" {
  value = local.concourse_domain
}

output "concourse_username" {
  value = var.concourse_username
  sensitive = true
}

output "concourse_password" {
  value = random_password.concourse_password.result
  sensitive = true
}
