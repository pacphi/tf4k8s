module "nginx_ingress" {
  source = "../../../modules/nginx-ingress"

  kubeconfig_path = var.kubeconfig_path
  extra_args_key = var.extra_args_key
  extra_args_value = var.extra_args_value
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

variable "extra_args_key" {
  description = "extraArgs key; for when you would like to pass additional startup flags to the nginx-controller"
  default = ""
}

variable "extra_args_value" {
  description = "extraArgs value; for when you would like to pass additional startup flags to the nginx-controller"
  default = ""
}