# Terraform for creating an AWS S3 bucket

Sometimes you need a place to put your stuff.  Why not use Amazon's blob storage?

This sample takes advantage of the [
terraform-aws-s3-bucket](https://github.com/terraform-aws-modules/terraform-aws-s3-bucket) module in the Terraform Registry.

Starts with the assumption that you will use an IAM user's credentials that has appropriate role/permissions to create/delete an S3 bucket.

## Edit `terraform.tfvars`

Amend the values for

* `bucket_name`

## Create

```
./create-blobstore.sh
```

## Destroy

To tear it down

```
./destroy-blobstore.sh
```
