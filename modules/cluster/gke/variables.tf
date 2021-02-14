variable "random_cluster_suffix" {
  description = "Random 6 byte hex suffix for cluster name"
  type        = string
  default     = ""
}

variable "gcp_service_account_credentials" {
  description = "Path to service account credentials file in JSON format"
  type        = string
}

variable "gcp_project" {
  description = "GCP Project ID"
  type        = string
}

variable "gcp_region" {
  description = "GCP region (e.g. `europe-west3-c` => Frankfurt)"
  type        = string
  default     = "us-west1"
}

variable "gke_name" {
  description = "GKE cluster name (e.g. `k8s`)"
  type        = string
  default     = "simple-gke-cluster"
}

variable "gke_pool_name" {
  description = "GKE node pool name (e.g. `k8s-node-pool`)"
  type        = string
  default     = "simple-gke-cluster-pool"
}

variable "gke_nodes" {
  description = "GKE Kubernetes worker nodes (e.g. `2`)"
  type        = number
  default     = 2
}

variable "gke_preemptible" {
  description = "Use GKE preemptible nodes (e.g. `false`)"
  type        = bool
  default     = false
}

variable "gke_node_type" {
  description = "GKE node instance type (e.g. `n1-standard-2` => 1vCPU, 7.5 GB RAM)"
  type        = string
  default     = "n1-standard-2"
}

variable "gke_serviceaccount" {
  description = "GCP service account for GKE (e.g. `default`)"
  type        = string
  default     = "default"
}

variable "gke_oauth_scopes" {
  description = "GCP OAuth scopes for GKE (https://www.terraform.io/docs/providers/google/r/container_cluster.html#oauth_scopes)"
  type        = list(string)
  default = [
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring",
    "https://www.googleapis.com/auth/servicecontrol",
    "https://www.googleapis.com/auth/service.management.readonly",
    "https://www.googleapis.com/auth/trace.append"
  ]
}

variable "all_inbound" {
  description = "Allow inbound access from any IP address?"
  type = bool
  default = true
}

variable "release_channel" {
  type = string
  default = "RAPID"
}