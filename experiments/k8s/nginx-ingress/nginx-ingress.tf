module "nginx_ingress" {
  source = "../../../modules/nginx-ingress"
}

variable "kubeconfig_path" {}