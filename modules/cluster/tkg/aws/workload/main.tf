resource "null_resource" "tkg_gzipped_tkg_mgmt_cluster_config_extraction" {
  triggers = {
    gzipped_config_exists = fileexists(var.path_to_gzipped_management_cluster_config)
  }
  provisioner "local-exec" {
    triggers = {
      gzipped_config_exists = fileexists(var.path_to_gzipped_management_cluster_config)
    }
    environment = {
      GZIPPED_CONFIG_EXISTS = self.triggers.gzipped_config_exists
      GZIPPED_CONFIG = var.path_to_gzipped_management_cluster_config
    }
    command =<<EOT
      if [ "$GZIPPED_CONFIG_EXISTS" == "true" ]; then 
        tar -xvf $GZIPPED_CONFIG -C ~ 
      fi
    EOT
  }
}
data "local_file" "config" {
  filename = fileexists(var.path_to_gzipped_management_cluster_config) ? pathexpand("~/.tkg/config.yaml"): pathexpand(var.path_to_tkg_config_yaml)

  depends_on = [
    null_resource.tkg_gzipped_tkg_mgmt_cluster_config_extraction
  ]
}

resource "null_resource" "tkg_workload_cluster" {
  triggers = {
    config_filename = data.local_file.config.filename
    cluster_name = "tkg-aws-${var.environment}-work-cluster"
    
  }
  provisioner "local-exec" {
    environment = {
      TKG_CONFIG = self.triggers.config_filename
      TKG_PLAN_NAME = var.tkg_plan
      TKG_K8S_VERSION = var.tkg_kubernetes_version
      TKG_WORKLOAD_CLUSTER_NAME = self.triggers.cluster_name
      TKG_WORKLOAD_CLUSTER_CONTROL_PLANE_NODE_COUNT = var.tkg_control_plane_node_count
      TKG_WORKLOAD_CLUSTER_WORKER_NODE_COUNT = var.tkg_worker_node_count
    }
    command = "tkg create cluster $TKG_WORKLOAD_CLUSTER_NAME -p $TKG_PLAN_NAME -c $TKG_WORKLOAD_CLUSTER_CONTROL_PLANE_NODE_COUNT -w $TKG_WORKLOAD_CLUSTER_WORKER_NODE_COUNT --kubernetes-version $TKG_K8S_VERSION --config $TKG_CONFIG --v 6"
  }
  provisioner "local-exec" {
    when = destroy
    environment = {
      TKG_CONFIG = self.triggers.config_filename
      TKG_WORKLOAD_CLUSTER_NAME = self.triggers.cluster_name
    }
    command = "tkg delete cluster $TKG_WORKLOAD_CLUSTER_NAME --config $TKG_CONFIG --v 6"
  }
}

resource "null_resource" "tkg_cluster_credentials" {
  triggers = {
    config_filename = data.local_file.config.filename
    cluster_name = "tkg-aws-${var.environment}-work-cluster"
  }
  provisioner "local-exec" {
    environment = {
      TKG_CONFIG = self.triggers.config_filename
      TKG_WORKLOAD_CLUSTER_NAME = self.triggers.cluster_name
    }
    command = "tkg get credentials $TKG_WORKLOAD_CLUSTER_NAME --config $TKG_CONFIG"
  }

  depends_on = [
    null_resource.tkg_workload_cluster
  ]
}

resource "null_resource" "kubeconfig" {
  triggers = {
    cluster_name = "tkg-aws-${var.environment}-work-cluster"
  }
  provisioner "local-exec" {
    environment = {
      TKG_WORKLOAD_CLUSTER_NAME = self.triggers.cluster_name
    }
    command = "kubectl config use-context $TKG_WORKLOAD_CLUSTER_NAME-admin@$TKG_WORKLOAD_CLUSTER_NAME"
  }

  depends_on = [
    null_resource.tkg_cluster_credentials
  ]
}
