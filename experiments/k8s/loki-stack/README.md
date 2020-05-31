# Terraform for installing Loki Stack

Uses [kubernetes](https://www.terraform.io/docs/providers/kubernetes/index.html), [helm](https://www.terraform.io/docs/providers/helm/index.html) and [k14s](https://github.com/k14s/terraform-provider-k14s) Terraform providers to install [Loki Stack](https://github.com/grafana/loki/blob/v1.5.0/docs/installation/helm.md).

Loki is a horizontally-scalable, highly-available, multi-tenant log aggregation system inspired by Prometheus. It is designed to be very cost effective and easy to operate. It does not index the contents of the logs, but rather a set of labels for each log stream.

Starts with the assumption that you have already provisioned a cluster.

## Edit `terraform.tfvars`

Amend the values for

* `domain`
* `kubeconfig_path`

## Install

```
./create-loki-stack.sh
```

Use credentials to log into Grafana and [configure](https://github.com/grafana/loki/blob/v1.5.0/docs/getting-started/grafana.md) a new Loki data source

Set the data source URL to be `http://{cluster-ip}:{port}`. To obtain the `{cluster-ip}` and `{port}`, execute

```
kubectl get service loki-stack --namespace loki-stack
```

Query logs from any container using [LogQL](https://github.com/grafana/loki/blob/master/docs/logql.md)

## Remove

```
./destroy-loki-stack.sh
```
