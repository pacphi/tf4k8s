resource "random_id" "cluster_name" {
  byte_length = 6
}

## Get your workstation external IPv4 address:
data "http" "workstation-external-ip" {
  url   = "http://ipv4.icanhazip.com"
}

locals {
  workstation-external-cidr = "${chomp(data.http.workstation-external-ip.body)}/32"
}

resource "azurerm_resource_group" "rg" {
  name     = var.aks_resource_group
  location = var.aks_region
}

## Log Analytics for Container logs (enable_logs = true)
resource "azurerm_log_analytics_workspace" "logworkspace" {
  count               = var.enable_logs ? 1 : 0
  name                = "${var.aks_name}-${random_id.cluster_name[count.index].hex}-law"
  location            = azurerm_resource_group.rg[count.index].location
  resource_group_name = azurerm_resource_group.rg[count.index].name
  sku                 = "PerGB2018"
}

resource "azurerm_log_analytics_solution" "logsolution" {
  count                 = var.enable_logs ? 1 : 0
  solution_name         = "ContainerInsights"
  location              = azurerm_resource_group.rg[count.index].location
  resource_group_name   = azurerm_resource_group.rg[count.index].name
  workspace_resource_id = azurerm_log_analytics_workspace.logworkspace[count.index].id
  workspace_name        = azurerm_log_analytics_workspace.logworkspace[count.index].name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

## AKS
# Get latest Kubernetes version available
data "azurerm_kubernetes_service_versions" "current" {
  location = var.aks_region
  depends_on = [azurerm_resource_group.rg]
}

# AKS with standard kubenet network profile
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.aks_name}-${random_id.cluster_name.hex}"
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.aks_name}-${random_id.cluster_name.hex}"
  api_server_authorized_ip_ranges = [ local.workstation-external-cidr ]

  default_node_pool {
    name            = var.aks_pool_name
    node_count      = var.aks_nodes
    vm_size         = var.aks_node_type
    os_disk_size_gb = var.aks_node_disk_size
  }

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  service_principal {
    client_id     = var.az_client_id
    client_secret = var.az_client_secret
  }

  network_profile {
    network_plugin = "kubenet"
  }

  tags = {
    Project   = "k8s",
    ManagedBy = "terraform"
  }
}

## Static Public IP Address to be used e.g. by Nginx Ingress
resource "azurerm_public_ip" "public_ip" {
  name                = "k8s-public-ip-${random_id.cluster_name.hex}"
  location            = azurerm_kubernetes_cluster.aks.location
  resource_group_name = azurerm_kubernetes_cluster.aks.node_resource_group
  allocation_method   = "Static"
  domain_name_label   = "${var.aks_name}-${random_id.cluster_name.hex}"
}

## kubeconfig file
resource "local_file" "kubeconfigaks" {
  content  = azurerm_kubernetes_cluster.aks.kube_config_raw
  filename = "/tmp/aks/${var.aks_name}-${random_id.cluster_name.hex}-kubeconfig"
}
