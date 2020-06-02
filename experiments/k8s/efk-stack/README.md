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

In Kibana, go to the `Management` → `Kibana` → `Index Patterns` page, and click `Create index pattern`.

Enter `metricbeat-*` and on the next step select the `@timestamp` field to finalize the creation of the index pattern in Kibana.

Create another index pattern using `kubernetes-*` and `@timestamp`

Visit the `Discover` page.  You should be able to see and query for any and all log records or metrics being collected from your Kubernetes cluster.

## Remove

```
./destroy-efk-stack.sh
```
