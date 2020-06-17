# Terraform for installing Project Contour

Uses k14s [kapp](https://github.com/k14s/terraform-provider-k14s/blob/master/docs/k14s_kapp.md) Terraform provider to install [Contour](https://projectcontour.io/getting-started/).

Starts with the assumption that you have already provisioned a cluster.

## Edit `terraform.tfvars`

Amend the values for

* `kubeconfig_path`


## Install

```
./create-contour.sh
```

## Remove

```
./destroy-contour.sh
```
