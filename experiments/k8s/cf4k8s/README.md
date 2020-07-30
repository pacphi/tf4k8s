# Terraform for installing cf-for-k8s

Deploy the Cloud Foundry Application Runtime on Kubernetes.

Starts with the assumption that you have already provisioned a cluster.

## Edit `terraform.tfvars`

Amend the values for

* `base_domain`
* `registry_domain`
* `repository_prefix`
* `registry_password`
* `kubeconfig_path`

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
./create-cf4k8s.sh <iaas> <base_domain>
```
> Set `iaas` to be one of [ amazon, azure, gcp ] and set `base_domain` to be the same value as defined in `terraform.tfvars`

## Remove

```
./destroy-cf4k8s.sh <iaas>
```
> Set `iaas` to be one of [ amazon, azure, gcp ]