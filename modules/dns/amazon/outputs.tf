output "base_domain" {
  value = trim(aws_route53_zone.zone.name, ".")
}

output "hosted_zone_id" {
  value = aws_route53_zone.zone.id
}