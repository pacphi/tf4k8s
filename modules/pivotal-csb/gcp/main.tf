data "local_file" "db_ca_cert_file" {
  filename = pathexpand(var.db_ca_cert_file)
}

data "local_file" "db_client_cert_file" {
  filename = pathexpand(var.db_client_cert_file)
}

data "local_file" "db_client_key_file" {
  filename = pathexpand(var.db_client_key_file)
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "random_uuid" "api_user" {}

resource "random_password" "api_password" {
  length = 36
  special = false
}

data "template_file" "config_template" {
  template = file("${path.module}/templates/manifest.tpl")

  vars = {
    gcp_credentials = var.gcp_credentials

    db_host = var.db_host
    db_name = var.db_name
    db_user = var.db_user
    db_port = var.db_port
    db_password = var.db_password
    db_ca_cert = indent(6, "|\n${data.local_file.db_ca_cert_file.content}")
    db_client_cert = indent(6, "|\n${data.local_file.db_client_cert_file.content}")
    db_client_key = indent(6, "|\n${data.local_file.db_client_key_file.content}")

    api_user = random_uuid.api_user.result
    api_password = random_password.api_password.result

    docker_image = "${var.registry_repository}/${var.container_image}:${var.container_tag}"
    docker_username = var.registry_username
  }
}

resource "local_file" "config" {
  filename = "${path.module}/manifest.yml"
  content = data.template_file.config_template.rendered
}

resource "null_resource" "target_and_authenticate" {
  provisioner "local-exec" {
    environment = {
      CF_API_ENDPOINT = var.cf_api_endpoint
      CF_ADMIN_USERNAME = var.cf_admin_username
      CF_ADMIN_PASSWORD = var.cf_admin_password
    }
    command = "cf api $CF_API_ENDPOINT && cf auth $CF_ADMIN_USERNAME $CF_ADMIN_PASSWORD"
  }

  provisioner "local-exec" {
    when = destroy

    command = "cf api --unset"
  }
}

resource "null_resource" "establish_org_and_space" {
  provisioner "local-exec" {
    command = "cf create-org osb && cf create-space default -o osb && cf target -o osb -s default"
  }

  provisioner "local-exec" {
    when = destroy

    command = "cf delete-org osb -f"
  }

  depends_on = [ null_resource.target_and_authenticate ]
}

resource "null_resource" "push_broker" {
  provisioner "local-exec" {
    environment = {
      APP_NAME = "cloud-service-broker"
      CF_DOCKER_PASSWORD = var.registry_password
    }
    command = "cf push $APP_NAME -f ${local_file.config.filename}"
  }

  provisioner "local-exec" {
    when = destroy

    environment = {
      APP_NAME = "cloud-service-broker"
    }
    command = "cf delete $APP_NAME -r -f"
  }

  depends_on = [ null_resource.establish_org_and_space ]
}

resource "null_resource" "register_broker" {
  provisioner "local-exec" {
    environment = {
      APP_NAME = "cloud-service-broker"
      BROKER_NAME = "csb-${random_id.suffix.hex}"
      SECURITY_USER_NAME = random_uuid.api_user.result
      SECURITY_USER_PASSWORD = random_password.api_password.result
    }
    command = "cf create-service-broker $BROKER_NAME $SECURITY_USER_NAME $SECURITY_USER_PASSWORD https://$(cf app $APP_NAME | grep 'routes:' | cut -d ':' -f 2 | xargs) --space-scoped || cf update-service-broker $BROKER_NAME $SECURITY_USER_NAME $SECURITY_USER_PASSWORD https://$(cf app $APP_NAME | grep 'routes:' | cut -d ':' -f 2 | xargs)"
  }

  provisioner "local-exec" {
    when = destroy
    environment = {
      BROKER_NAME = "csb-${random_id.suffix.hex}"
    }
    command = "cf delete-service-broker $BROKER_NAME -f"
  }

  depends_on = [ null_resource.push_broker ]
}