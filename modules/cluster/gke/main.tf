resource "random_id" "cluster_name" {
  byte_length = 6
}

resource "random_id" "username" {
  byte_length = 14
}

resource "random_id" "password" {
  byte_length = 18
}

## Get your workstation external IPv4 address:
data "http" "workstation-external-ip" {
  url   = "http://ipv4.icanhazip.com"
}

locals {
  workstation-external-cidr = var.all_inbound ? "0.0.0.0/0" : "${chomp(data.http.workstation-external-ip.body)}/32"
}

resource "google_container_cluster" "gke" {
  provider           = google-beta
  name               = "${var.gke_name}-${random_id.cluster_name.hex}"
  location           = var.gcp_region
  project            = var.gcp_project

  release_channel {
    channel = var.release_channel
  }
  
  maintenance_policy {
    recurring_window {
      start_time = "2020-01-01T00:00:00-07:00"
      end_time = "2050-01-01T06:00:00-07:00"
      recurrence = "FREQ=DAILY"
    }
  }

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  node_config {
    service_account = var.gke_serviceaccount
  }

  # (Required for private cluster, optional otherwise) network (cidr) from which cluster is accessible
  master_authorized_networks_config {
    cidr_blocks {
      display_name = "gke-admin"
      cidr_block   = local.workstation-external-cidr
    }
  }

  addons_config {
    network_policy_config {
      disabled = false
    }
  }

  network_policy {
    enabled = true
  }

  // Allow plenty of time for each operation to finish (default was 10m)
  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
}

resource "google_container_node_pool" "np" {
  project    = var.gcp_project
  name       = "np-${random_id.cluster_name.hex}"
  location   = var.gcp_region
  cluster    = google_container_cluster.gke.name
  node_count = var.gke_nodes

  node_config {
    machine_type = var.gke_node_type
    disk_type    = "pd-ssd"
    disk_size_gb = 30
    image_type   = "COS"
    preemptible     = var.gke_preemptible
    service_account = var.gke_serviceaccount

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = var.gke_oauth_scopes
  }

}

module "gke_auth" {
  source               = "terraform-google-modules/kubernetes-engine/google//modules/auth"

  project_id           = var.gcp_project
  cluster_name         = "${var.gke_name}-${random_id.cluster_name.hex}"
  location             = var.gcp_region
  use_private_endpoint = true
}

resource "local_file" "kubeconfig" {
  content  = module.gke_auth.kubeconfig_raw
  filename = pathexpand("~/.tf4k8s/gcp/${var.gke_name}-${random_id.cluster_name.hex}-kubeconfig")
}
