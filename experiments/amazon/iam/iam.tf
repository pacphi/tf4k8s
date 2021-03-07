# Delegate to Terraform Registry module
# @see https://registry.terraform.io/modules/terraform-aws-modules/iam/aws/2.10.0/submodules/iam-user
module "iam_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "~> 2.0"

  name = var.name
  password_reset_required = false
  force_destroy = true
  permissions_boundary = var.permissions_boundary
  pgp_key = var.pgp_key
  tags = var.tags
}

variable "name" {
  description = "Desired name for the IAM user"
  default = "terraform"
}

variable "permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the user"
  default = ""
}

variable "pgp_key" {
  description = "Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Used to encrypt password and access key. pgp_key is required when create_iam_user_login_profile is set to true."
  sensitive = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type = map(string)
  default = {}
}

variable "region" {
  description = "An AWS region (e.g., us-east-1)"
  default = "us-west-2"
}

output "keybase_password_decrypt_command" {
  value = module.iam_user.keybase_password_decrypt_command
}

output "keybase_password_pgp_message" {
  value = module.iam_user.keybase_password_pgp_message
}

output "keybase_secret_key_decrypt_command" {
  value = module.iam_user.keybase_secret_key_decrypt_command
}

output "keybase_secret_key_pgp_message" {
  value = module.iam_user.keybase_secret_key_pgp_message
}

output "pgp_key" {
  description = "PGP key used to encrypt sensitive data for this user (if empty - secrets are not encrypted)"
  value = module.iam_user.pgp_key
}

output "this_iam_access_key_encrypted_secret" {
  description = "The encrypted secret, base64 encoded"
  value = module.iam_user.this_iam_access_key_encrypted_secret
}

output "this_iam_access_key_id" {
  description = "The access key ID"
  value = module.iam_user.this_iam_access_key_id
}

output "this_iam_access_key_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the secret"
  value = module.iam_user.this_iam_access_key_key_fingerprint
}

output "this_iam_access_key_secret" {
  description = "The access key secret"
  value = module.iam_user.this_iam_access_key_secret
}

output "this_iam_access_key_status" {
  description = "Active or Inactive. Keys are initially active, but can be made inactive by other means."
  value = module.iam_user.this_iam_access_key_status
}

output "this_iam_user_arn" {
  description = "The ARN assigned by AWS for this user"
  value = module.iam_user.this_iam_user_arn
}

output "this_iam_user_login_profile_encrypted_password" {
  description = "The encrypted password, base64 encoded"
  value = module.iam_user.this_iam_user_login_profile_encrypted_password
}

output "this_iam_user_login_profile_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the password"
  value = module.iam_user.this_iam_user_login_profile_key_fingerprint
}

output "this_iam_user_unique_id" {
  description = " The unique ID assigned by AWS"
  value = module.iam_user.this_iam_user_unique_id
}

provider "aws" {
  version = ">= 3.9.0"
  region  = var.region
}
