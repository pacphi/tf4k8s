# Terraform for creating a Log sink for a TKGi cluster

Consult the [ClusterLogSink and LogSink Resources](https://docs.pivotal.io/tkgi/1-9/create-sinks.html#define-log-sinks) section of the Tanzu Kubernetes Grid Integrated Edition documentation.

Starts with the assumption that you have already provisioned a cluster.

## Copy sample configuration

```
cp terraform.tfvars.sample terraform.tfvars
```

## Edit `terraform.tfvars`

Amend the values for

* `tkgi_cluster_name`
* `sink_hostname`
* `sink_port`
* `sink_insecure_skip_verify`
* `kubeconfig_path`

## Create

```
./create-logsink.sh
```

## Destroy

To tear it down

```
./destroy-logsink.sh
```
