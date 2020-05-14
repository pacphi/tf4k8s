data "google_dns_managed_zone" "root_zone" {
  name = var.root_zone_name
}

resource "google_dns_managed_zone" "zone" {
  name        = "${var.environment_name}-zone"
  dns_name    = "${var.dns_prefix}.${data.google_dns_managed_zone.root_zone.dns_name}"
  description = "Google DNS managed zone for ${var.dns_prefix}.${data.google_dns_managed_zone.root_zone.dns_name}"
}

resource "google_dns_record_set" "ns_record" {
  managed_zone = data.google_dns_managed_zone.root_zone.name
  name = "${var.dns_prefix}.${data.google_dns_managed_zone.root_zone.dns_name}"
  rrdatas = google_dns_managed_zone.zone.name_servers

  ttl = 30
  type = "NS"

}
