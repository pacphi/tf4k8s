# Terraform for installing VMware Tanzu Application Service for Kubernetes

Deploy a commercially supported beta of the Cloud Foundry Application Runtime on Kubernetes.

Starts with the assumption that you have already provisioned a cluster.

## Edit `terraform.tfvars`

Amend the values for

* `base_domain`
* `registry_domain`
* `repository_prefix`
* `registry_password`
* `pivnet_username`
* `pivnet_password`
* `kubeconfig_path`

Install VMware Tanzu Application Service for Kubernetes

## Create a new file named `iaas.auto.tfvars`

Add and (of course) amend values for

```
email = ...
domain = ...
```

then depending upon your IaaS, uncomment and amend values for blocks of configuration as follows

### Amazon

```
dns_zone_id = ...
```

### Azure

```
client_id = ...
client_secret = ...
tenant_id = ...
subscription_id = ...
resource_group_name = ...
```

### GCP

```
project = ...
```

## on Kind

If you're deploying [locally](https://github.com/cloudfoundry/cf-for-k8s/blob/master/docs/deploy-local.md#deploying-cf-for-k8s-locally) to a [kind](https://kind.sigs.k8s.io/docs/user/quick-start/) cluster then you must set the following additional environment variable

```
export IS_KIND=true
```

## Install

```
./create-tas4k8s.sh <iaas> <base_domain> <tanzu-network-api-token>
```
> Set `iaas` to be one of [ amazon, azure, gcp ], set `base_domain` to be the same value as defined in `terraform.tfvars`, and set`tanzu-network-api-token` to be a valid API token for an [account](https://network.pivotal.io/users/dashboard/edit-profile) on the [Tanzu Network](https://network.pivotal.io)

### Where are the install images sourced?

If you intend to install a pre-release build of VMware Tanzu Application Service for Kubernetes, then edit `terraform.tfvars` so that it includes:

```
pivnet_registry_hostname = "dev.registry.pivotal.io"
```
> Note `pivnet_username` must be a user group member in order to pull images from this registry.

Verify and/or update the values for `TAS4K8S_VERSION` and `TAS4K8S_PRODUCT_FILE_ID` in [download-tas4k8s.sh](../../../ytt-libs/tas4k8s/scripts/download-tas4k8s.sh).  (If the `TAS4K8S_VERSION` variable's value in that script includes `.build`, you're using a pre-release build).


## Remove

```
./destroy-tas4k8s.sh <iaas>
```
> Set `iaas` to be one of [ amazon, azure, gcp ]

