data "local_file" "tekton_pipelines" {
  filename = "${path.module}/api-resources/release.yaml"
}

data "local_file" "tekton_dashboard" {
  filename = "${path.module}/api-resources/tekton-dashboard-release.yaml"
}

data "k14s_kbld" "tekton_pipelines_config" {
  config_yaml = data.local_file.tekton_pipelines.content

  debug_logs = true
}

data "k14s_kbld" "tekton_dashboard_config" {
  config_yaml = data.local_file.tekton_dashboard.content

  debug_logs = true
}

resource "local_file" "tekton_pipelines_config" {
  content     = data.k14s_kbld.tekton_pipelines_config.result
  filename = "${path.module}/.ytt/release.yaml"
}

resource "local_file" "tekton_dashboard_config" {
  content     = data.k14s_kbld.tekton_dashboard_config.result
  filename = "${path.module}/.ytt/tekton-dashboard-release.yaml"
}

resource "k14s_kapp" "tekton_pipelines" {
  app = "tekton-pipelines"

  namespace = "default"

  config_yaml = local_file.tekton_pipelines_config.content
}

resource "k14s_kapp" "tekton_dashboard" {
  app = "tekton-dashboard"

  namespace = "default"

  config_yaml = local_file.tekton_dashboard_config.content

  depends_on = [ k14s_kapp.tekton_pipelines ]
}
