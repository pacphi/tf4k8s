locals {
  jenkins_instance_config_file_path = var.path_to_jenkins_instance_config == "" ? "${path.module}/templates/jenkins.yaml" : var.path_to_jenkins_instance_config
}

data "http" "jenkins_crd" {
  url = "https://raw.githubusercontent.com/jenkinsci/kubernetes-operator/${var.jenkins_k8s_operator_commit_hash}/deploy/crds/jenkins_v1alpha2_jenkins_crd.yaml"
}

data "http" "operator" {
  url = "https://raw.githubusercontent.com/jenkinsci/kubernetes-operator/${var.jenkins_k8s_operator_commit_hash}/deploy/all-in-one-v1alpha2.yaml"
}

data "template_file" "jenkins" {
  template = file(local.jenkins_instance_config_file_path)

  vars = {
    instance_name = var.jenkins_instance_name
  }
}

resource "kubernetes_namespace" "jenkins" {
  metadata {
    name = var.jenkins_namespace
  }
}

resource "k14s_kapp" "jenkins_crd" {
  app = "jenkins-crd"
  namespace = "default"

  config_yaml = data.http.jenkins_crd.body

  debug_logs = true
}

resource "k14s_kapp" "jenkins_operator" {
  app = "jenkins-operator"
  namespace = var.jenkins_namespace

  config_yaml = data.http.operator.body

  debug_logs = true

  depends_on = [
    kubernetes_namespace.jenkins,
    k14s_kapp.jenkins_crd
  ]
}

resource "k14s_kapp" "jenkins" {
  app = "jenkins"
  namespace = var.jenkins_namespace

  config_yaml = data.template_file.jenkins.rendered

  debug_logs = true

  depends_on = [
    k14s_kapp.jenkins_operator
  ]
}