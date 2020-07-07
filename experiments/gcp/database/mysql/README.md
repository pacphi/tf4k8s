# Terraform for creating a GCP MySQL database instance

Sometimes you need a database.  Why not use Google Cloud Platform's Cloud SQL?

Cloud SQL is an easy-to-use service that delivers fully managed SQL databases in the cloud. Cloud SQL provides PostgreSQL, SQL Server, and MySQL databases.

This sample takes advantage of the [mysql](https://registry.terraform.io/modules/GoogleCloudPlatform/sql-db/google/3.2.0/submodules/mysql) sub-module of [sql-db](https://registry.terraform.io/modules/GoogleCloudPlatform/sql-db/google/3.2.0) within the Terraform Registry.

Starts with the assumption that you will use a service account's credentials that has appropriate role/permissions to create/delete a Cloud SQL database instance.

## Edit `terraform.tfvars`

Amend the values for

* `project`
* `region`
* `zone`
* `database_version`
* `database_tier`
* `database_username`
* `encryption_key_name`
* `name`
* `additional_databases`
* `additional_users`
* `service_account_credentials`

## Create

```
./create-database.sh
```

## Use

You'll probably want to connect to the database instance you just created, huh?

In order to obtain the ssl_key, ssl_cert, and ssl_ca you'll, there's a convenient script to generate them and a sample mysql client command

### Edit terraform.tfvars 

> This time within the `connect` subdirectory

```
cd connect
```

then amend values for

* `project`
* `region`
* `instance_name`
* `database_username`
* `instance_public_ip_address`
* `service_account_credentials`

### Obtain encrypted connection details

```
./create-connection.sh
```

### Destroy encrypted connection details

```
./destroy-connection.sh
```

## Destroy

To tear it down

```
./destroy-database.sh
```

## Troubleshooting

If you're going to setup the database instance with an `encryption_key_name` then you will need to perform some work outside of Terraform as described [here](https://cloud.google.com/sql/docs/mysql/configure-cmek#grantkey).  The service account you use to create the database instance must also have the `roles/cloudkms.cryptoKeyEncrypterDecrypter` role assigned.