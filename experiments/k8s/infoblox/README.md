# Terraform for creating Infoblox resources

This experiment flexes the Infoblox [provider](https://www.terraform.io/docs/providers/infoblox/index.html). It will create an A record on a targeted Infoblox DNS and return the IP address and hostname.

Starts with the assumption that you have already provisioned a cluster.


## Copy sample configuration

```
cp terraform.tfvars.sample terraform.tfvars
```

## Edit `terraform.tfvars`

Amend the values for

* `infoblox_cidr`
* `infoblox_dns_zone`
* `infoblox_password`
* `infoblox_server`
* `infoblox_tenant_id`
* `infoblox_user`
* `infoblox_vmname`
* `kubeconfig_path`


## Create

```
./create-infoblox.sh
```

## Destroy

To tear it down

```
./destroy-infoblox.sh
```
