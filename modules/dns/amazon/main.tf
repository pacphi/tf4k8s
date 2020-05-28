data "aws_route53_zone" "selected" {
  zone_id = var.base_hosted_zone_id
}

resource "aws_route53_zone" "zone" {
  name = "${var.domain_prefix}.${data.aws_route53_zone.selected.name}"
  force_destroy = true
}

resource "aws_route53_record" "ns" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = aws_route53_zone.zone.name
  type    = "NS"
  ttl     = "30"

  records = aws_route53_zone.zone.name_servers
}