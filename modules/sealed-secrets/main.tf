data "local_file" "sealed_secrets" {
  filename = "${path.module}/api-resources/controller.yaml"
}

data "k14s_kbld" "sealed_secrets_config" {
  config_yaml = data.local_file.sealed_secrets.content

  debug_logs = true
}

resource "local_file" "sealed_secrets_config" {
  content     = data.k14s_kbld.sealed_secrets_config.result
  filename = "${path.module}/.ytt/controller.yaml"
}

resource "k14s_kapp" "sealed_secrets" {
  app = "kubeseal"

  namespace = "default"

  config_yaml = local_file.sealed_secrets_config.content
}