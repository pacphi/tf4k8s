variable "aks_resource_group" {
  description = "Microsoft Azure Resource group name"
  type        = string
}

variable "enable_logs" {
  description = "Enable azure log analtics for container logs"
  type        = bool
  default     = false
}

variable "ssh_public_key" {
  description = "Path to your SSH public key (e.g. `~/.ssh/id_rsa.pub`)"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "az_client_id" {
  description = "Azure Service Principal appId"
  type        = string
}

variable "az_client_secret" {
  description = "Azure Service Principal password"
  type        = string
}

variable "az_tenant_id" {
  description = "Azure Service Principal tenant"
  type        = string
}

variable "az_subscription_id" {
  description = "Azure Subscription Id"
  type        = string
}

variable "aks_region" {
  description = "AKS region (e.g. `West Europe`) -> `az account list-locations --output table`"
  type        = string
  default     = "West US 2"
}

variable "aks_name" {
  description = "AKS cluster name (e.g. `k8s-aks`)"
  type        = string
  default     = "k8s"
}

variable "aks_nodes" {
  description = "AKS Kubernetes worker nodes (e.g. `2`)"
  type        = number
  default     = 2
}

variable "aks_node_type" {
  description = "AKS node pool instance type (e.g. `Standard_D1_v2` => 1vCPU, 3.75 GB RAM)"
  type        = string
  default     = "Standard_D1_v2"
}

variable "aks_pool_name" {
  description = "AKS agent node pool name (e.g. `k8s-aks-nodepool`)"
  type        = string
  default     = "k8snodepool"
}

variable "aks_node_disk_size" {
  description = "AKS node instance disk size in GB (e.g. `30` => minimum: 30GB, maximum: 1024)"
  type        = number
  default     = 30
}

variable "all_inbound" {
  description = "Allow inbound access from any IP address?"
  type = bool
  default = true
}