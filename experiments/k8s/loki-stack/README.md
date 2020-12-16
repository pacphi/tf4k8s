# Terraform for installing Loki Stack

Uses [kubernetes](https://www.terraform.io/docs/providers/kubernetes/index.html), [helm](https://www.terraform.io/docs/providers/helm/index.html) and [k14s](https://github.com/k14s/terraform-provider-k14s) Terraform providers to install [Loki Stack](https://github.com/grafana/helm-charts/tree/main/charts/loki-stack).

Loki is a horizontally-scalable, highly-available, multi-tenant log aggregation system inspired by Prometheus. It is designed to be very cost effective and easy to operate. It does not index the contents of the logs, but rather a set of labels for each log stream.

Starts with the assumption that you have already provisioned a cluster.

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
./create-loki-stack.sh
```

Use credentials to log into Grafana and [configure](https://grafana.com/docs/loki/latest/getting-started/grafana/) a new Loki data source

Set the data source URL to be `http://{cluster-ip}:{port}`. To obtain the `{cluster-ip}` and `{port}`, execute

```
kubectl get service loki-stack --namespace loki-stack
```

Query logs from any container using [LogQL](https://grafana.com/docs/loki/latest/logql/)

## Remove

```
./destroy-loki-stack.sh
```
