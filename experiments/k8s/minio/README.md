# Terraform for creating a Minio blob store

Sometimes you need a place to put your stuff.  Why not use Minio's blob storage?

This sample makes use of this Bitnami [chart](https://hub.helm.sh/charts/bitnami/minio).

Starts with the assumption that you have already provisioned a cluster.

## Edit `terraform.tfvars`

Amend the values for

* `domain`
* `ingress`
* `kubeconfig_path`

## Create

```
./create-blobstore.sh
```

## Destroy

To tear it down

```
./destroy-blobstore.sh
```
