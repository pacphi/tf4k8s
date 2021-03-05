output "avi_controller_username" {
  value = var.avi_controller_username
}

output "avi_controller_password" {
  value = random_password.avi_controller_password.result
}
