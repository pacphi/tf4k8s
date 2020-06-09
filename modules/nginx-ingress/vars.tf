variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

variable "extra_args_key" {
  description = "extraArgs key; for when you would like to pass addition startup flags to the nginx-controller"
  default = ""
}

variable "extra_args_value" {
  description = "extraArgs value; for when you would like to pass addition startup flags to the nginx-controller"
  default = ""
}
