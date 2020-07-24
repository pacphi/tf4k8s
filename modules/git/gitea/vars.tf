variable "domain" {}

variable "ingress" {
  description = "Used to specify which Ingress controller should serve a particular Ingress object."
  default = "nginx"
}

variable "persistence_enabled" {
  description = "Create PVCs to store gitea and postgres data?"
  default = false
}

variable "persistence_storageclass" {
  description = "NStorageClass to use for dynamic provision if not 'default'"
  default = ""
}

variable "kubeconfig_path" {}