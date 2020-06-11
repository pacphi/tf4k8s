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

## Install

```
./create-tas4k8s.sh <base_domain> <tanzu-network-api-token>
```
> Set `base_domain` to be the same value as defined in `terraform.tfvars`

## Remove

```
./destroy-tas4k8s.sh
```
