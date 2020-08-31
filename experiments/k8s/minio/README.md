# Terraform for creating a Minio blob store

Sometimes you need a place to put your stuff.  Why not use Minio's S3-compatible blob storage?

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

## Use

Consult the [MinIO Client Complete Guide](https://docs.min.io/docs/minio-client-complete-guide.html)

### Set alias

```
❯ mc alias set minio https://{minio-domain} {access-key} {secret-key}
mc: Configuration written to `/home/cphillipson/.mc/config.json`. Please update your access credentials.
mc: Successfully created `/home/cphillipson/.mc/share`.
mc: Initialized share uploads `/home/cphillipson/.mc/share/uploads.json` file.
mc: Initialized share downloads `/home/cphillipson/.mc/share/downloads.json` file.
Added `minio` successfully.
```
> Replace `{minio-domain}`, `{access-key}` and `{secret-key}` above with the domain and credentials used to authenticate to your Minio instance

### Example workflow

#### Create new bucket

```
❯ mc mb minio/ksm-charts
Bucket created successfully `minio/ksm-charts`.
```

#### List buckets and objects

```
❯ mc ls minio
[2020-08-31 05:35:05 PDT]      0B ksm-charts/
```

#### Remove existing bucket

```
❯ mc rb minio/ksm-charts
Removed `minio/ksm-charts` successfully.
```

## Destroy

To tear it down

```
./destroy-blobstore.sh
```
