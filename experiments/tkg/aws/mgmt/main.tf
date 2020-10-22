module "tkg_aws_mgmt_cluster" {
  source = "../../../../modules/cluster/tkg/aws/mgmt"

  environment = var.environment
  tkg_plan = var.tkg_plan
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
  path_to_tkg_config_yaml = var.path_to_tkg_config_yaml
}

variable "environment" {
  description = "An arbitrary name used to describe this Tanzu Kubernetes Grid environment"
}

variable "tkg_plan" {
  description = "A Tanzu Kubernetes Grid plan. Choices are: [ dev, prod ]."
  default = "dev"
}

variable "aws_secret_key_id" {
  description = ""
}

variable "aws_secret_access_key" {
  description = ""
}

variable "aws_region" {
  description = "A valid AWS region (e.g., us-east-1)"
  default = "us-west-2"
}

variable "aws_node_az" {
  description = "Use for management cluster control plane node placement in a primary availability zone"
  default = "us-west-2a"
}

variable "aws_node_az_1" {
  description = "Use for management cluster control plane node placement in a secondary availability zone. Set this variable if you want to deploy a prod management cluster with three control plane nodes. This availability zone must be in the same region as AWS_NODE_AZ."
  default = "us-west-2b"
}

variable "aws_node_az_2" {
  description = "Use for management cluster control plane node placement in a tertiary availability zone. Set this variable if you want to deploy a prod management cluster with three control plane nodes. This availability zone must be in the same region as AWS_NODE_AZ."
  default = "us-west-2c"
}

variable "aws_private_node_cidr" {
  description = "Use to define the primary private node CIDR block"
  default = "10.0.0.0/24"
}

variable "aws_private_node_cidr_1" {
  description = "Use to define the secondary private node CIDR block"
  default = "10.0.2.0/24"
}

variable "aws_private_node_cidr_2" {
  description = "Use to define the tertiary private node CIDR block"
  default = "10.0.4.0/24"
}

variable "aws_public_node_cidr" {
  description = "Use to define the primary public node CIDR block"
  default = "10.0.1.0/24"
}

variable "aws_public_node_cidr_1" {
  description = "Use to define the secondary public node CIDR block"
  default = "10.0.3.0/24"
}

variable "aws_public_node_cidr_2" {
  description = "Use to define the tertiary public node CIDR block"
  default = "10.0.5.0/24"
}

variable "aws_ssh_key_name" {
  description = "Name of an existing SSH key pair to Amazon EC2"
  default = "default.pem"
}

variable "aws_vpc_cidr" {
  description = "Use to define a VPC CIDR block when you want Tanzu Kubernetes Grid to create a new VPC in the selected region"
  default = "10.0.0.0/16"
}

variable "service_cidr" {
  description = "The CIDR range to use for the Kubernetes services. The recommended range is 100.64.0.0/13. Change this value only if the recommended range is unavailable."
  default = "100.64.0.0./13"
}

variable "cluster_cidr" {
  description = "The CIDR range to use for pods. The recommended range is 100.96.0.0/11. Change this value only if the recommended range is unavailable."
  default = "100.96.0.0./11"
}

variable "control_plane_machine_type" {
  description = "The EC2 compute instance type for all control plane nodes (e.g., t3.medium)"
  default = "m5a.large"
}

variable "node_machine_type" {
  description = "The EC2 compute instance type for all worker nodes (e.g., t3.xlarge)"
  default = "m5a.xlarge"
}

variable "path_to_tkg_config_yaml" {
  description = "The path to the configuration used by Tanzu Kubernetes Grid CLI (e.g., ~/.tkg/{env}/config.yaml)"
}
