# Terraform for installing Stratos

Uses Terraform providers to install [Stratos](https://github.com/cloudfoundry/stratos/tree/master/deploy/cloud-foundry#deploy-stratos-from-docker-image).

Stratos is an Open Source Web-based UI (Console) for managing Cloud Foundry. It allows users and administrators to both manage applications running in the Cloud Foundry cluster and perform cluster management tasks.

Assumes that you have:

* already provisioned a cluster
* an installation of cf4k8s or tas4k8s with admin account credentials
  * and that Docker support has been [enabled](https://docs.cloudfoundry.org/adminguide/docker.html#feature-flag)
* a marketplace service offering and plan is available so that a MySQL or PostgreSQL database instance can be created and bound to the Stratos Docker Hub [image](https://hub.docker.com/r/splatform/stratos/tags) deployed as an application
  * you might consider Pivotal Cloud Service Broker

## Edit `terraform.tfvars`

Amend the values for

* `container_image`
* `container_tag`
* `cf_api_endpoint`
* `cf_admin_username`
* `cf_admin_password`
* `cf_service_offering_name`
* `cf_service_offering_plan`
* `cf_service_name`

## Install

```
./create-stratos.sh
```

## Remove

```
./destroy-stratos.sh
```
