# Terraform for configuring External DNS

Uses [k14s](https://github.com/k14s/terraform-provider-k14s) Terraform provider to configure [external-dns](https://github.com/kubernetes-sigs/external-dns).

Starts with the assumption that you have already provisioned an EKS cluster.

## Copy sample configuration

```
cp terraform.tfvars.sample terraform.tfvars
```

## Edit `terraform.tfvars`

Amend the values for

* `aws_access_key`
* `aws_secret_key`
* `region`
* `domain_filter`
* `kubeconfig_path`


## Create

```
./create-external-dns.sh
```

## Teardown

```
./destroy-external-dns.sh
```
