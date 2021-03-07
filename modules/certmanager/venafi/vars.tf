variable "venafi_policy_zone_guid" {}

variable "venafi_tpp_access_token" {
  sensitive = true
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  type = string
  default = "~/.kube/config"
}