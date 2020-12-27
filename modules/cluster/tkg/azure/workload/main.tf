resource "null_resource" "install_specific_version_of_kubectl" {
  provisioner "local-exec" {
    environment = {
      TKG_K8S_VERSION = var.tkg_kubernetes_version
    }
    command =<<EOT
      KUBECTL_VERSION=$(echo $TKG_K8S_VERSION | sed -e 's/v\(.*\)+vmware\(.*\)/\1/')
      wget -O kubectl https://storage.googleapis.com/kubernetes-release/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl
      chmod +x kubectl
      mv kubectl /usr/local/bin
    EOT
  }
}

resource "null_resource" "gzipped_tkg_mgmt_cluster_config_extraction" {
  provisioner "local-exec" {
    environment = {
      GZIPPED_CONFIG = var.path_to_gzipped_management_cluster_config
    }
    command =<<EOT
      if [ -f "$GZIPPED_CONFIG" ]; then 
        tar -xvf $GZIPPED_CONFIG -C ~ 
      fi
    EOT
  }

  depends_on = [
    null_resource.install_specific_version_of_kubectl
  ]
}

data "local_file" "config" {
  filename = fileexists(var.path_to_gzipped_management_cluster_config) ? pathexpand("~/.tkg/config.yaml"): pathexpand(var.path_to_tkg_config_yaml)

  depends_on = [
    null_resource.gzipped_tkg_mgmt_cluster_config_extraction
  ]
}

resource "null_resource" "tkg_workload_cluster" {
  triggers = {
    config_filename = data.local_file.config.filename
    cluster_name = "tkg-az-${var.environment}-work-cluster"
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
    cluster_name = "tkg-az-${var.environment}-work-cluster"
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
    cluster_name = "tkg-az-${var.environment}-work-cluster"
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
