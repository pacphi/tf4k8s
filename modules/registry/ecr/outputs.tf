output "ecr_id" {
  description = "The ID of the Container Registry"
  value = aws_ecr_repository.ecr.registry_id
}

output "ecr_name" {
  value = join("", [ var.registry_name, random_id.suffix.hex ])
}


data "aws_ecr_authorization_token" "token" {
  registry_id = aws_ecr_repository.ecr.registry_id
}

output "ecr_admin_username" {
  description = "The username associated with the Container Registry admin account"
  value = data.aws_ecr_authorization_token.token.user_name
}

output "ecr_admin_password" {
  description = "The password associated with the Container Registry admin account"
  value = data.aws_ecr_authorization_token.token.password
}

output "ecr_endpoint" {
  description = "The URL that can be used to log into the container image registry."
  value = data.aws_ecr_authorization_token.token.proxy_endpoint
}

output "ecr_repository_url" {
  description = "The URL of the container image repository (in the form {aws_account_id}.dkr.ecr.region.amazonaws.com/{repository-name})."
  value = aws_ecr_repository.ecr.repository_url
}