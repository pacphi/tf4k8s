# Terraform for installing cf-for-k8s

// TODO Add description

Starts with the assumption that you have already provisioned a cluster.

Edit `terraform.tfvars` and amend the values for

* `project`
* `base_domain`
* `acme_email`
* `registry_domain`
* `registry_repository`
* `registry_password`
* `kubeconfig_path`

Install cf-for-k8s

```
./create-cf4k8s.sh <base_domain>
```
> Set `base_domain` to be the same value as defined in `terraform.tfvars`

To tear it down

```
./destroy-cf4k8s.sh
```
