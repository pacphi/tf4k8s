# Terraform for installing Harbor

Uses [kubernetes](https://www.terraform.io/docs/providers/kubernetes/index.html), [helm](https://www.terraform.io/docs/providers/helm/index.html) and [k14s](https://github.com/k14s/terraform-provider-k14s) Terraform providers to install [Harbor](https://goharbor.io).

Harbor is an open source container image registry that secures images with role-based access control, scans images for vulnerabilities, and signs images as trusted.

Starts with the assumption that you have already provisioned a cluster.

## Edit `terraform.tfvars`

Amend the values for

* `domain`
* `ingress`
* `kubeconfig_path`

## Install

```
./create-harbor.sh
```

## Remove

```
./destroy-harbor.sh
```
