variable "environment" {
  description = "An arbitrary name used to describe this Tanzu Kubernetes Grid environment"
}

variable "tkg_plan" {
  description = "A Tanzu Kubernetes Grid plan. Choices are: [ dev, prod ]."
  default = "dev"
}

variable "az_environment" {
  description = "The target cloud provider environment (e.g., AzurePublicCloud). See https://docs.microsoft.com/en-us/cli/azure/manage-clouds-azure-cli?view=azure-cli-latest#list-available-clouds"
  default = "AzurePublicCloud"
}

variable "az_tenant_id" {
  description = "The tenant ID of your Azure account"
}

variable "az_subscription_id" {
  description = "The subscription ID of your Azure subscription"
}

variable "az_client_id" {
  description = "The client ID of the app for Tanzu Kubernetes Grid that you registered with Azure"
}

variable "az_client_secret" {
  description = "Client secret. See https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.2/vmware-tanzu-kubernetes-grid-12/GUID-mgmt-clusters-azure.html#register-app."
}

variable "az_location" {
  description = "The name of the Azure region in which to deploy the management cluster. Pick one value from 'name' column if executing [ az account list-locations -o table ]."
  default = "westus2"
}

variable "az_ssh_public_key_b64" {
  description = "Your SSH public key, created following https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.2/vmware-tanzu-kubernetes-grid-12/GUID-mgmt-clusters-azure.html, converted into base64 with newlines removed. For example, with a public key file id_rsa.pub, set AZURE_SSH_PUBLIC_KEY_B64 to the output of cat id_rsa.pub | base64 | tr -d ‘\r\n’"
}

variable "az_resource_group_name" {
  description = "A resource group name that already exists in your Azure account. Must be unique to each management cluster."
}

variable "service_cidr" {
  description = "The CIDR range to use for the Kubernetes services. If left blank it will be auto-created."
  default = ""
}

variable "cluster_cidr" {
  description = "The CIDR range to use for pods. If left blank it will be auto-created."
  default = ""
}

variable "control_plane_machine_type" {
  description = "The Azure compute instance type for all control plane nodes (e.g., Standard_D2s_v3).  Must be from among [ DSv3, FSv2 ] series."
  default = "Standard_D2s_v3"
}

variable "node_machine_type" {
  description = "The Azure compute instance type for all worker nodes (e.g., Standard_D4s_v3).  Must be from among [ DSv3, FSv2 ] series."
  default = "Standard_D4s_v3"
}

variable "path_to_tkg_config_yaml" {
  description = "The path to the configuration used by Tanzu Kubernetes Grid CLI"
  default = "~/.tkg/config.yaml"
}
