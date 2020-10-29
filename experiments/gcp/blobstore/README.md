# Terraform for creating a GCP storage bucket

Sometimes you need a place to put your stuff.  Why not use Google Cloud Platform's blob storage?

This sample takes advantage of the [
terraform-google-storage-bucket](https://github.com/SweetOps/terraform-google-storage-bucket) module in the Terraform Registry.

Starts with the assumption that you will use a service account's credentials that has appropriate role/permissions to create/delete a GCP storage bucket.

## Copy sample configuration

```
cp terraform.tfvars.sample terraform.tfvars
```

## Edit `terraform.tfvars`

Amend the values for

* `gcp_project`
* `gcp_region`
* `gcp_bucket_name`
* `environment`
* `namespace`

## Create

```
./create-blobstore.sh
```

## Destroy

To tear it down

```
./destroy-blobstore.sh
```
