# Terraform for installing VMware Tanzu Application Service for Kubernetes

Deploy a commercially supported beta of the Cloud Foundry Application Runtime on Kubernetes.

Starts with the assumption that you have already provisioned a cluster.

## Edit `terraform.tfvars`

Amend the values for

* `base_domain`
* `registry_domain`
* `registry_repository`
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

## Install

```
./create-tas4k8s.sh <iaas> <base_domain> <tanzu-network-api-token>
```
> Set `iaas` to be one of [ amazon, azure, gcp ], set `base_domain` to be the same value as defined in `terraform.tfvars`, and set`tanzu-network-api-token` to be a valid API token for an [account](https://network.pivotal.io/users/dashboard/edit-profile) on the [Tanzu Network](https://network.pivotal.io)

## Remove

```
./destroy-cf4k8s.sh <iaas>
```
> Set `iaas` to be one of [ amazon, azure, gcp ]
