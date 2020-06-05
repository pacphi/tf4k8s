# Terraform for creating an Azure Storage Container

Sometimes you need a place to put your stuff.  Why not use Azure's blob storage?

This sample mimics the [azurerm_storage_container](https://www.terraform.io/docs/providers/azurerm/r/storage_container.html) example.

Starts with the assumption that you will use a service principal's credentials that has appropriate permissions to create/delete a storage account and storage container.

## Edit `terraform.tfvars`

Amend the values for

* `az_subscription_id`
* `az_client_id`
* `az_client_secret`
* `az_tenant_id`
* `resource_group_name`
* `storage_account_name`
* `storage_container_name`

## Create

```
./create-blobstore.sh
```

## Destroy

To tear it down

```
./destroy-blobstore.sh
```
