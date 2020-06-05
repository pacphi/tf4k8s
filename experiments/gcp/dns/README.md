# Terraform for creating Cloud DNS managed zone and NS recordset

Oftentimes, you'll have the requirement to add and manage DNS sub-domains.

This sample assumes your authoritative names servers and DNS record information is managed external to Google.  It's also assumed a managed zone (known as the "root zone") has already been set up in Google Cloud DNS.

> You'll want to make sure you've set an environment variable (e.g., `GOOGLE_APPLICATION_CREDENTIALS`) that the [Terraform Google Provider](https://www.terraform.io/docs/providers/google/index.html) [credentials](https://www.terraform.io/docs/providers/google/guides/provider_reference.html#credentials-1) configuration attribute will use and that the account has appropriate role assigned with permissions to successfully execute creation of a managed zone and record set.


## Edit `terraform.tfvars` 

Amend the values for

* `project`
* `root_zone_name`
* `environment_name`
* `dns_prefix`


## Create a zone

All we're doing here is creating a new managed zone and adding an NS record to the "root zone".

```
./create-zone.sh
```

## Teardown zone

```
./destroy-zone.sh
```
