output "ip" {
  value = infoblox_a_record.add_dns.ip_addr
}

output "hostname" {
  value = "${infoblox_a_record.add_dns.vm_name}.${infoblox_a_record.add_dns.zone}"
}
