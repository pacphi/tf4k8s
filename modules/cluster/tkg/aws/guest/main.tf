data "local_file" "config" {
  filename = pathexpand(var.path_to_tkg_config_yaml)
}

resource "random_string" "suffix" {
  length = 4
  special = false
}

resource "null_resource" "tkg_guest_cluster" {
  triggers = {
    config_filename = data.local_file.config.filename
    cluster_name = "tkg-${var.environment}-${random_string.suffix.result}-guest"
  }
  provisioner "local-exec" {
    environment = {
      TKG_CONFIG = self.triggers.config_filename
      TKG_PLAN_NAME = var.tkg_plan
      TKG_K8S_VERSION = var.tkg_kuberenetes_version
      TKG_GUEST_CLUSTER_NAME = self.triggers.cluster_name
      TKG_GUEST_CLUSTER_CONTROL_PLANE_COUNT = var.tkg_control_plane_count
      TKG_GUEST_CLUSTER_WORKER_NODE_COUNT = var.tkg_worker_node_count
    }
    command = "tkg create cluster $TKG_GUEST_CLUSTER_NAME -p $TKG_PLAN_NAME -c $TKG_GUEST_CLUSTER_CONTROL_PLANE_NODE_COUNT -w $TKG_GUEST_CLUSTER_WORKER_NODE_COUNT --kubernetes-version $TKG_K8S_VERSION --config $TKG_CONFIG"
  }
  provisioner "local-exec" {
    when = destroy
    environment = {
      TKG_CONFIG = self.triggers.config_filename
      TKG_GUEST_CLUSTER_NAME = self.triggers.cluster_name
    }
    command = "tkg delete cluster $TKG_GUEST_CLUSTER_NAME --config $TKG_CONFIG"
  }
}
