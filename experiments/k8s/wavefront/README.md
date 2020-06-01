# Terraform for installing VMware Tanzu Observability (aka Wavefront by VMWare)

Uses [kubernetes](https://www.terraform.io/docs/providers/kubernetes/index.html) and [helm](https://www.terraform.io/docs/providers/helm/index.html) Terraform providers to install [Wavefront by VMWare](https://docs.wavefront.com/tutorial_getting_started.html).

Wavefront provides a comprehensive solution for monitoring Kubernetes.

Collects real-time metrics from all layers of a Kubernetes environment (clusters, nodes, pods, containers, and the Kubernetes control plane).
Supports plugins such as Prometheus, Telegraf, and Systemd; enabling you to collect metrics from various workloads.

Starts with the assumption that you have already provisioned a cluster.

## Edit `terraform.tfvars`

Amend the values for

* `cluster_name`
* `wavefront_url`
* `wavefront_api_token`
* `kubeconfig_path`

## Install

```
./create-wavefront.sh
```

## Remove

```
./destroy-wavefront.sh
```
