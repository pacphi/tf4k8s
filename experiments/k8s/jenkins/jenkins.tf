module "jenkins" {
  source = "../../../modules/jenkins"

  kubeconfig_path = var.kubeconfig_path
  jenkins_instance_name = var.jenkins_instance_name
  jenkins_namespace = var.jenkins_namespace
  jenkins_k8s_operator_commit_hash = var.jenkins_k8s_operator_commit_hash
  path_to_jenkins_instance_config = var.path_to_jenkins_instance_config
}

variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}

variable "jenkins_instance_name" {
  default = "prod-jenkins"
}

variable "jenkins_namespace" {
  default = "jenkins"
}

variable "jenkins_k8s_operator_commit_hash" {
  // this commit corresponds to version v0.5.0
  default = "fe81e5ab3df0b79d532a4cd5d576df4c0586955a"
}

variable "path_to_jenkins_instance_config" {
  default = ""
}