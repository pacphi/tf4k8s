variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

variable "traefik_log_level" {
  description = "Logging level for Traefik. See https://doc.traefik.io/traefik/observability/logs/#level."
  default = "DEBUG"
}
