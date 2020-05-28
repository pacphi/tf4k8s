# Terraform for installing cf-for-k8s

Deploy the Cloud Foundry Application Runtime on Kubernetes.

Starts with the assumption that you have already provisioned a cluster.

## Edit `terraform.tfvars`

Amend the values for

* `base_domain`
* `acme_email`
* `registry_domain`
* `registry_repository`
* `registry_password`
* `kubeconfig_path`

## Install

```
./create-cf4k8s.sh <base_domain>
```
> Set `base_domain` to be the same value as defined in `terraform.tfvars`

## Remove

```
./destroy-cf4k8s.sh
```
