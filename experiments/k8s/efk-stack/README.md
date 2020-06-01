# Terraform for installing Elasticsearch, Fluentbit, and Kibana

Uses [kubernetes](https://www.terraform.io/docs/providers/kubernetes/index.html), [helm](https://www.terraform.io/docs/providers/helm/index.html) and [k14s](https://github.com/k14s/terraform-provider-k14s) Terraform providers to install:

* Elasticsearch
* Fluentbit
* Kibana

Starts with the assumption that you have already provisioned a cluster.

## Edit `terraform.tfvars`

Amend the values for

* `domain`
* `kubeconfig_path`

## Install

```
./create-efk-stack.sh
```

## Remove

```
./destroy-efk-stack.sh
```
