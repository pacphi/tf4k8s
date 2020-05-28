# Create a new IAM user on Amazon Web Services

Create an IAM user using the [iam-user](https://registry.terraform.io/modules/terraform-aws-modules/iam/aws/2.10.0/submodules/iam-user) Terraform Registry module.  If you want your AWS access secret to be encrypted consider generating a PGP key using [keybase](https://dev.to/shermisaurus/tooling-saturdays-1-setting-and-using-gpg-public-encryption-keys-with-keybase-io-1onj).

## Authenticate

Assumption here is that we are using an owner account or an account with administrator permissions.

```
aws configure
```

You'll be prompted to supply

* `access key`
* `secret key`
* `region`
* `output format`


## Edit `terraform.tfvars` and update

* `name`
* `permissions_boundary`
* `pgp_key`
* `region`


## Create a new user account

```
./create-iam.sh
```

Repeat the [Authenticate](#authenticate) step above with your new credentials. Don't forget to decrypt your secret if you supplied a PGP key.

## Destroy the user account

```
./destroy-iam.sh
```
