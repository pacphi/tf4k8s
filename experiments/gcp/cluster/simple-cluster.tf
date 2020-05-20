module "gke" {
  source  = "../../../modules/cluster/gke"

  gcp_project = var.gcp_project
  gcp_service_account_credentials = var.gcp_service_account_credentials
  gcp_region = var.gcp_region
  gke_name = var.gke_name
  gke_pool_name = var.gke_pool_name
  gke_nodes = var.gke_nodes
  gke_preemptible = var.gke_preemptible
  gke_node_type = var.gke_node_type
}

variable "gcp_project" {
  description = "A Google Cloud Platform project id"
}

variable "gcp_service_account_credentials" {
  description = "The path to your Google Cloud Platform IAM service account credentials file"
}

variable "gcp_region" {
  description = "A valid Google Cloud Platform region"
  default = "us-west1"
}

variable "gke_name" {
  description = "A name for your Google Kubernetes Engine cluster"
}

variable "gke_pool_name" {
  description = "A name for your Google Kubernetes Engine cluster node pool"
}

variable "gke_nodes" {
  description ="The number of nodes that will be created in each availability zone of the region you specified"
  default = 2
}

variable "gke_preemptible" {
  description = "Whether or not to use preemptible nodes (@see https://cloud.google.com/blog/products/containers-kubernetes/cutting-costs-with-google-kubernetes-engine-using-the-cluster-autoscaler-and-preemptible-vms)"
  default = false
}

variable "gke_node_type" {
  description = "The machine type used for each node in the cluster (@see https://cloud.google.com/compute/docs/machine-types)"
  default = "n1-standard-2"
}

output "path_to_kubeconfig" {
  value = module.gke.path_to_kubeconfig
}

output "gke_cluster_name" {
  value = module.gke.gke_cluster_name
}

output "gcp_region" {
  value = module.gke.gcp_region
}

output "gke_node_version_deployed" {
  value = module.gke.gke_node_version_deployed
}
