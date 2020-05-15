module "managed-zone" {
    source = "../../../modules/dns/gcp"

    root_zone_name = "ironleg-zone"
    environment_name = "lab"
    dns_prefix = "lab"
}

output "zone_name" {
    value = module.managed-zone.zone_name
}

output "zone_subdomain" {
    value = module.managed-zone.zone_subdomain
}

provider "google" {
  version = ">=3.21.0"
  project = "fe-cphillipson"
}
