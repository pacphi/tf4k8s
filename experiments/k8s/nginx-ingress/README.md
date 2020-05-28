# Terraform for configuring NGINX Ingress

Uses [helm](https://www.terraform.io/docs/providers/helm/index.html) Terraform provider to configure [nginx ingress](https://kubernetes.github.io/ingress-nginx/).

Starts with the assumption that you have already provisioned a cluster.

## Edit `terraform.tfvars`

Amend the values for

* `kubeconfig_path`

## Install

```
./create-nginx-ingress.sh
```

## Remove

```
./destroy-nginx-ingress.sh
```
