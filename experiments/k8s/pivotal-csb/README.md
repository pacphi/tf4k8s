# Terraform for installing Pivotal Cloud Service Broker

Uses Terraform providers to install [Pivotal Cloud Service Broker](https://github.com/pivotal/cloud-service-broker).

Assumes that you have:

* already provisioned a cluster
* a Pivotal Okta account
  * release artifacts are sourced from a private Github repository
* an installation of cf4k8s or tas4k8s with admin account credentials
  * and that Docker support has been [enabled](https://docs.cloudfoundry.org/adminguide/docker.html#feature-flag)
* already provisioned a database host and a database named `servicebroker` to store metadata for each brokered service instance instantiated
* account credentials with roles and permissions to create, update and destroy a curated collection of managed services on any of Azure, AWS or GCP

## Download artifacts

```
./download-release-artifacts.sh
```

## Create Dockerfile

```
./create-dockerfile.sh {iaas}
```
> where `{iaas}` is one of [ `aws`, `azure`, `gcp` ]

## Build container image

```
./build-container-image.sh {iaas}
```

## Publish container image

```
./publish-container-image.sh {registry_domain} {registry_repository} {registry_username} {registry_password} {image} {tag}
```

## Edit `terraform.tfvars`

Amend the values for

* `db_host`
* `db_user`
* `db_port`
* `db_name`
* `db_ca_cert_file`
* `db_client_cert_file`
* `db_client_key_file`
* `registry_repository`
* `registry_username`
* `registry_password`
* `container_image`
* `container_tag`
* `cf_api_endpoint`
* `cf_admin_username`
* `cf_admin_password`

## Reference credentials for cloud provider

### for AWS

These are source from `~/.aws/credentials`.

### for Azure

Create a file called `azure-csb.auto.tfvars` and add the following key-value pairs

```
az_subscription_id = "d67c4971-e658-4g9e-ab4c-d2acbcb65474"
az_client_id = "a7859f75-dfc3-474f-b094-0abd4egb9d5e"
az_tenant_id = "19247f74-261g-4db2-6a50-c65a6377b0d2"
```
> These are sample credentials. Replace the values above with your own credentials.

### for GCP

These are sourced from an environment variable `GOOGLE_APPLICATION_CREDENTIALS`


## Install

```
./create-pivotal-csb.sh {iaas}
```

## Remove

```
./destroy-pivotal-csb.sh {iaas}
```
