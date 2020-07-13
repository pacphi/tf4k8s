resource "random_password" "session_store_secret" {
  length = 24
  special = false
}

data "template_file" "config_template" {
  template = file("${path.module}/templates/manifest.tpl")

  vars = {
    docker_image = "${var.container_image}:${var.container_tag}"
    session_store_secret = random_password.session_store_secret.result
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
    command = "cf create-org stratos && cf create-space default -o stratos && cf target -o stratos -s default"
  }

  provisioner "local-exec" {
    when = destroy

    command = "cf delete-org stratos -f"
  }

  depends_on = [ null_resource.target_and_authenticate ]
}

resource "null_resource" "enable_service_access" {
  provisioner "local-exec" {
    environment = {
      CF_SERVICE_OFFERING_NAME = var.cf_service_offering_name
      CF_SERVICE_OFFERING_PLAN = var.cf_service_offering_plan 
    }
    command = "cf enable-service-access $CF_SERVICE_OFFERING_NAME -b $(cf curl /v2/service_brokers | jq '.resources[]' | jq '.entity.name' | tr -d '\"') -o stratos -p $CF_SERVICE_OFFERING_PLAN"
  }

  depends_on = [ null_resource.establish_org_and_space ]
}

resource "null_resource" "create_database_instance" {
  provisioner "local-exec" {
    environment = {
      CF_SERVICE_OFFERING_NAME = var.cf_service_offering_name
      CF_SERVICE_OFFERING_PLAN = var.cf_service_offering_plan
      CF_SERVICE_NAME = var.cf_service_name
    }
    command = "cf create-service $CF_SERVICE_OFFERING_NAME $CF_SERVICE_OFFERING_PLAN $CF_SERVICE_NAME"
  }

  provisioner "local-exec" {
    when = destroy

    environment = {
      CF_SERVICE_NAME = var.cf_service_name
    }
    command = "cf delete-service $CF_SERVICE_NAME -f"
  }

  depends_on = [ null_resource.enable_service_access ]
}

resource "null_resource" "wait_for_database_to_become_available" {
  provisioner "local-exec" {
    environment = {
      CF_SERVICE_NAME = var.cf_service_name
      BASE_PATH = path.module
    }
    command = "./$BASE_PATH/scripts/wait-for-service.sh $CF_SERVICE_NAME"
  }

  depends_on = [ null_resource.create_database_instance ]
}

resource "null_resource" "push_stratos" {
  provisioner "local-exec" {
    command = "cf push -f ${local_file.config.filename}"
  }

  provisioner "local-exec" {
    when = destroy

    environment = {
      APP_NAME = "console"
    }
    command = "cf delete $APP_NAME -r -f"
  }

  depends_on = [ null_resource.wait_for_database_to_become_available ]
}
