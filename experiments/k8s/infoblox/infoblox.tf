module "infoblox_ip" {
  source = "../../../modules/dns/infoblox"

  infoblox_cidr      = var.infoblox_cidr
  infoblox_dns_zone  = var.infoblox_dns_zone
  infoblox_password  = var.infoblox_password
  infoblox_server    = var.infoblox_server
  infoblox_tenant_id = var.infoblox_tenant_id
  infoblox_user      = var.infoblox_user
  infoblox_vmname    = var.infoblox_vmname
}

variable "infoblox_cidr" {
  description = "CIDR to use when allocating IP address space"
}

variable "infoblox_dns_zone" {
  description = "DNS zone"
}

variable "infoblox_password" {
  description = "Infoblox account password"
  sensitive = true
}

variable "infoblox_server" {
  description = "Hostname or IP address of Infoblox server"
}

variable "infoblox_tenant_id" {
  description = "Infoblox tenant id"
  sensitive = true
}

variable "infoblox_user" {
  description = "Infoblox account username"
  sensitive = true
}

variable "infoblox_vmname" {
  description = "The name to use for the DNS hostname and IP allocation"
}

output "ip" {
  value = module.infoblox_ip.ip
}

output "hostname" {
  value = module.infoblox_ip.hostname
}

