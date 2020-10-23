data "template_file" "config_additions" {
  template = file("${path.module}/templates/config-additions.tpl")

  vars = {
    az_resource_group_name = var.az_resource_group_name
    az_environment = var.az_environment
    az_tenant_id = var.az_tenant_id
    az_subscription_id = var.az_subscription_id
    az_client_id = var.az_client_id
    az_client_secret = var.az_client_secret
    az_location = var.az_location
    az_ssh_public_key_b64 = var.az_ssh_public_key_b64
    service_cidr = var.service_cidr
    cluster_cidr = var.cluster_cidr
    control_plane_machine_type = var.control_plane_machine_type
    node_machine_type = var.node_machine_type
  }
}

resource "null_resource" "tkg_management_cluster" {
  triggers = {
    env_name = var.environment
  }
  provisioner "local-exec" { 
    command = "tkg get management-cluster"
  }
}

data "local_file" "base_config" {
  filename = pathexpand("~/.tkg/config.yaml")

  depends_on = [
    null_resource.tkg_management_cluster
  ]
}

resource "local_file" "merged_config" {
  content = join("\n", [ data.local_file.base_config.content, data.template_file.config_additions.rendered ])
  filename = pathexpand(var.path_to_tkg_config_yaml)
}

resource "null_resource" "tkg_init" {
  triggers = {
    config_filename = local_file.merged_config.filename
    cluster_name = "tkg-az-${var.environment}-mgmt-cluster"
  }
  provisioner "local-exec" {
    environment = {
      TKG_CONFIG = self.triggers.config_filename
      TKG_PLAN_NAME = var.tkg_plan
      TKG_MANAGEMENT_CLUSTER_NAME = self.triggers.cluster_name
    }
    command = "tkg init --infrastructure azure --plan $TKG_PLAN_NAME --name $TKG_MANAGEMENT_CLUSTER_NAME --config $TKG_CONFIG"
  }
  provisioner "local-exec" {
    when = destroy
    environment = {
      TKG_CONFIG = self.triggers.config_filename
      TKG_MANAGEMENT_CLUSTER_NAME = self.triggers.cluster_name
    }
    command = "tkg delete management-cluster $TKG_MANAGEMENT_CLUSTER_NAME --config $TKG_CONFIG"
  }

}
