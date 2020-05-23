# Terraform for creating Azure DNS managed zone and NS recordset

Oftentimes, you'll have the requirement to add and manage DNS sub-domains.

This sample assumes your authoritative names servers and DNS record information is managed external to Microsoft Azure.  It's also assumed a managed zone (known as the "root zone") has already been set up in Azure DNS.

Edit `terraform.tfvars` and amend the values for

* `project`
* `root_zone_name`
* `environment_name`
* `dns_prefix`

All we're doing here is creating a new managed zone and adding an NS record to the "root zone".

```
./create-zone.sh
```

To tear it down

```
./destroy-zone.sh
```
