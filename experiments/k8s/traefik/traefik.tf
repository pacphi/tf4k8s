module "traefik" {
  source = "../../../modules/traefik"

  kubeconfig_path = var.kubeconfig_path
  traefik_log_level = var.traefik_log_level
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

variable "traefik_log_level" {
  description = "Logging level for Traefik. See https://doc.traefik.io/traefik/observability/logs/#level."
  default = "DEBUG"
}
