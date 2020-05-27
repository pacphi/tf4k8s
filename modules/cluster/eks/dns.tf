module "dns" {
  source = "../../modules/dns/aws"

  base_hosted_zone_id = var.base_hosted_zone_id
  dns_prefix          = var.dns_prefix
}