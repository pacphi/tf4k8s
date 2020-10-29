# Terraform for installing Stratos

Uses [kubernetes](https://www.terraform.io/docs/providers/kubernetes/index.html), [helm](https://www.terraform.io/docs/providers/helm/index.html) and [k14s](https://github.com/k14s/terraform-provider-k14s) Terraform providers to install [Stratos](https://github.com/cloudfoundry/stratos/blob/master/deploy/kubernetes/console/README.md).

Stratos is an Open Source Web-based UI (Console) for managing Cloud Foundry. It allows users and administrators to both manage applications running in the Cloud Foundry cluster and perform cluster management tasks.

Assumes that you have:

* already provisioned a cluster
* an installation of cf4k8s or tas4k8s with admin account credentials

## Copy sample configuration

```
cp terraform.tfvars.sample terraform.tfvars
```

## Edit `terraform.tfvars`

Amend the values for

* `domain`
* `ingress`
* `kubeconfig_path`

## Install

```
./create-stratos.sh
```

## Use

On the first visit to your Stratos instance you will be prompted to choose a method of authentication.  Choose `Local Admin`.  Complete that setup.

You'll then have the opportunity to register one or more API endpoints to cf4k8s or tas4k8s installations.

## Remove

```
./destroy-stratos.sh
```
