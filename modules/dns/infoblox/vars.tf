variable "infoblox_cidr" {
  description = "CIDR to use when allocating IP address space"
}

variable "infoblox_dns_zone" {
  description = "DNS zone"
}

variable "infoblox_password" {
  description = "Infoblox account password"
}

variable "infoblox_server" {
  description = "Hostname or IP address of Infoblox server"
}

variable "infoblox_tenant_id" {
  description = "Infoblox tenant id"
}

variable "infoblox_user" {
  description = "Infoblox account username"
}

variable "infoblox_vmname" {
  description = "The name to use for the DNS hostname and IP allocation"
}