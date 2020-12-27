module "tkg_azure_workload_cluster" {
  source = "../../../../modules/cluster/tkg/azure/workload"

  environment = var.environment
  tkg_plan = var.tkg_plan
  tkg_kubernetes_version = var.tkg_kubernetes_version
  tkg_control_plane_node_count = var.tkg_control_plane_node_count
  tkg_worker_node_count = var.tkg_worker_node_count
  path_to_tkg_config_yaml = var.path_to_tkg_config_yaml
  path_to_gzipped_management_cluster_config = var.path_to_gzipped_management_cluster_config
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
  default = "v1.19.3+vmware.1"
}

variable "tkg_control_plane_node_count" {
  description = "The number of nodes to provision in the workload cluster's control plane"
  default = 1
}

variable "tkg_worker_node_count" {
  description = "The number of woerker nodes to provision in the workload cluster's control plane"
  default = 3
}

variable "path_to_tkg_config_yaml" {
  description = "The path to the configuration used by Tanzu Kubernetes Grid CLI (e.g., ~/.tf4k8s/tkg/{env}/config.yaml)"
}

variable "path_to_gzipped_management_cluster_config" {
  description = "Optional path to the configuration used by Tanzu Kuberenetes Grid CLI (to be used when .tkg and .kube-tkg directories are not already available on or have be ported from another filesystem).  Configuration supplied a path to compressed file whose contents will be extracted the to the $HOME directory."
  default = ""
}

output "kubeconfig_contents" {
  value = module.tkg_azure_workload_cluster.kubeconfig_contents
}
