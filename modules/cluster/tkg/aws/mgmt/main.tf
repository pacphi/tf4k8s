data "template_file" "config_additions" {
  template = file("${path.module}/templates/config-additions.tpl")

  vars = {
    aws_secret_key_id = var.aws_secret_key_id
    aws_secret_access_key = var.aws_secret_access_key
    aws_region = var.aws_region
    aws_node_az = var.aws_node_az
    aws_node_az_1 = var.aws_node_az_1
    aws_node_az_2 = var.aws_node_az_2
    aws_private_node_cidr = var.aws_private_node_cidr
    aws_private_node_cidr_1 = var.aws_private_node_cidr_1
    aws_private_node_cidr_2 = var.aws_private_node_cidr_2
    aws_public_node_cidr = var.aws_public_node_cidr
    aws_public_node_cidr_1 = var.aws_public_node_cidr_1
    aws_public_node_cidr_2 = var.aws_public_node_cidr_2
    aws_ssh_key_name = var.aws_ssh_key_name
    aws_vpc_cidr = var.aws_vpc_cidr
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

resource "null_resource" "tkg_config_permissions" {
  triggers = {
    config_filename = local_file.merged_config.filename
  }
  provisioner "local-exec" {
    environment = {
      TKG_CONFIG = self.triggers.config_filename
    }
    command = "tkg config permissions aws --config $TKG_CONFIG"
  }
}

resource "null_resource" "tkg_init" {
  triggers = {
    config_filename = local_file.merged_config.filename
    cluster_name = "tkg-aws-${var.environment}-mgmt-cluster"
  }
  provisioner "local-exec" {
    environment = {
      TKG_CONFIG = self.triggers.config_filename
      TKG_PLAN_NAME = var.tkg_plan
      TKG_MANAGEMENT_CLUSTER_NAME = self.triggers.cluster_name
    }
    command = "tkg init --infrastructure aws --plan $TKG_PLAN_NAME --name $TKG_MANAGEMENT_CLUSTER_NAME --config $TKG_CONFIG --v 6"
  }
  provisioner "local-exec" {
    when = destroy
    environment = {
      TKG_CONFIG = self.triggers.config_filename
      TKG_MANAGEMENT_CLUSTER_NAME = self.triggers.cluster_name
    }
    // FIXME 
    // With tkg CLI 1.2 a defect exists -- simply issuing this command will fail due to an envrionment variable named AWS_B64ENCODED_CREDENTIALS not being set
    // While we could hack a remedy here, here's what steps you should take in addition to issuing a terraform destroy...
    //   Visit https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/tag/v0.5.5, download and install clusterawsadm
    //   Set the missing environment variable -- AWS_B64ENCODED_CREDENTIALS=$(clusterawsadm alpha bootstrap encode-aws-credentials)
    //   Execute the command below supplying the management cluster name
    command = "tkg delete management-cluster $TKG_MANAGEMENT_CLUSTER_NAME --config $TKG_CONFIG --v 6"
  }
  depends_on = [
    null_resource.tkg_config_permissions
  ]
}
