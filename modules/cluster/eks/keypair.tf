module "ssh_key_pair" {
  source                = "git::https://github.com/cloudposse/terraform-aws-key-pair.git?ref=master"
  namespace             = "tanzu"
  stage                 = random_id.cluster_name.hex
  name                  = var.ssh_key_name
  ssh_public_key_path   = pathexpand("~/.tf4k8s/aws/.ssh")
  generate_ssh_key      = "true"
  private_key_extension = ".pem"
  public_key_extension  = ".pub"
}