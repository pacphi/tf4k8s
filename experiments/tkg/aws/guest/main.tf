module "tkg_aws_guest_cluster" {
  source = "../../../../modules/cluster/tkg/aws/guest"

  environment = var.environment
  tkg_plan = var.tkg_plan
  tkg_kubernetes_version = var.tkg_kubernetes_version
  tkg_control_plane_node_count = var.tkg_control_plane_node_count
  tkg_worker_node_count = var.tkg_worker_node_count
  path_to_tkg_config_yaml = var.path_to_tkg_config_yaml
}

variable "environment" {
  description = "An arbitrary name used to describe this Tanzu Kubernetes Grid environment"
}

variable "tkg_plan" {
  description = "A Tanzu Kubernetes Grid plan. Choices are: [ dev, prod ]."
  default = "dev"
}

variable "tkg_kubernetes_version" {
  description = "A version of Kubernetes that is made available by a management cluster"
  default = "v1.19.1+vmware.2"
}

variable "tkg_control_plane_node_count" {
  description = "The number of nodes to provision in the guest cluster's control plane"
  default = 1
}

variable "tkg_worker_node_count" {
  description = "The number of woerker nodes to provision in the guest cluster's control plane"
  default = 3
}

variable "path_to_tkg_config_yaml" {
  description = "The path to the configuration used by Tanzu Kubernetes Grid CLI (e.g., ~/.tkg/{env}/config.yaml)"
}

output "kubeconfig_contents" {
  value = module.tkg_aws_guest_cluster.kubeconfig_contents
}
