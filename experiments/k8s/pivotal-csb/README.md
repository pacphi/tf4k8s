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

## Copy sample configuration

```
cp terraform.tfvars.sample terraform.tfvars
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

These are sourced from `~/.aws/credentials`.

### for Azure

Create a file called `credentials.auto.tfvars` in the `azure` sub-directory and add the following key-value pairs

```
az_subscription_id = "d67c4971-e658-4g9e-ab4c-d2acbcb65474"
az_client_id = "a7859f75-dfc3-474f-b094-0abd4egb9d5e"
az_client_secret = "b6248a79-ecc5-613d-b124-724d4egb9d3"
az_tenant_id = "19247f74-261g-4db2-6a50-c65a6377b0d2"
```
> These are sample credentials. Replace the values above with your own credentials.

### for GCP

These are sourced from an environment variable `GOOGLE_APPLICATION_CREDENTIALS`

Special note: make sure that the Service Networking API is [enabled](https://cloud.google.com/service-infrastructure/docs/service-networking/getting-started).


## Install

```
./create-pivotal-csb.sh {iaas}
```

## Remove

```
./destroy-pivotal-csb.sh {iaas}
```

## Verify that services have been installed

```
cf service-access
```

## Enabling service access

If you wish for (a) service(s) to be accessible in (an)other organization(s) and space(s) within your `cf4k8s` or `tas4k8s` installation, then please consult the following [guide](https://docs.cloudfoundry.org/services/access-control.html).


## Troubleshooting

### on GCP

If you're having trouble creating a Cloud SQL instance via the broker, as in this [article](https://stackoverflow.com/questions/56957596/cant-add-private-ip-vpc-to-new-google-cloud-sql-instance-with-gcloud).

You might try allocating an IP range for services

```
gcloud compute addresses create google-managed-services-default \
    --global \
    --purpose=VPC_PEERING \
    --prefix-length=16 \
    --description="Peering range for Google" \
    --network=default \
    --project=fe-cphillipson
```

and establishing a private connection to those services


```
gcloud services vpc-peerings connect \
    --service=servicenetworking.googleapis.com \
    --ranges=google-managed-services-default \
    --network=default \
    --project=fe-cphillipson
```

or

```
gcloud services vpc-peerings update \
    --service=servicenetworking.googleapis.com \
    --ranges=google-managed-services-default \
    --network=default \
    --project=fe-cphillipson \
    --force
```

The above samples are taken from [Configuring private services access](https://cloud.google.com/vpc/docs/configure-private-services-access).