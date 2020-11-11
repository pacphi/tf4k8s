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

data "google_container_engine_versions" "region" {
  provider       = google-beta
  location       = var.gcp_region
  version_prefix = var.gke_node_version_prefix
}

resource "google_container_cluster" "gke" {
  provider           = google-beta
  name               = "${var.gke_name}-${random_id.cluster_name.hex}"
  location           = var.gcp_region
  project            = var.gcp_project
  min_master_version = data.google_container_engine_versions.region.latest_master_version
  node_version       = data.google_container_engine_versions.region.latest_node_version

  release_channel {
    channel = var.release_channel
  }

  maintenance_policy {
    recurring_window {
      start_time = "2019-01-01T00:00:00-07:00"
      end_time = "2019-01-01T06:00:00-07:00"
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

  master_auth {
    username = random_id.username.hex
    password = random_id.password.hex

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  # (Required for private cluster, optional otherwise) network (cidr) from which cluster is accessible
  master_authorized_networks_config {
    cidr_blocks {
      display_name = "gke-admin"
      cidr_block   = local.workstation-external-cidr
    }
  }

  timeouts {
    create = "30m"
    update = "45m"
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  project    = var.gcp_project
  name       = "np-${random_id.cluster_name.hex}"
  location   = var.gcp_region
  cluster    = google_container_cluster.gke.name
  node_count = var.gke_nodes
  version    = data.google_container_engine_versions.region.latest_master_version

  node_config {
    preemptible     = var.gke_preemptible
    machine_type    = var.gke_node_type
    service_account = var.gke_serviceaccount

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = var.gke_oauth_scopes
  }

  management {
    auto_repair = false
  }
}

data "template_file" "kubeconfig" {
  template = file("${path.module}/kubeconfig-template.yaml")

  vars = {
    cluster_name    = google_container_cluster.gke.name
    endpoint        = google_container_cluster.gke.endpoint
    user_name       = google_container_cluster.gke.master_auth.0.username
    user_password   = google_container_cluster.gke.master_auth.0.password
    cluster_ca      = google_container_cluster.gke.master_auth.0.cluster_ca_certificate
    client_cert     = google_container_cluster.gke.master_auth.0.client_certificate
    client_cert_key = google_container_cluster.gke.master_auth.0.client_key
  }
}

resource "local_file" "kubeconfig" {
  content  = data.template_file.kubeconfig.rendered
  filename = pathexpand("~/.tf4k8s/gcp/${var.gke_name}-${random_id.cluster_name.hex}-kubeconfig")
}
