# Terraform for creating a Certificate Manager

This sample leverages [cert-manager](https://github.com/jetstack/cert-manager) to automate the management and issuance of TLS certificates from [Let's Encrypt](https://letsencrypt.org).

Starts with the assumption that you have already provisioned an EKS cluster.

## Copy sample configuration

```
cp terraform.tfvars.sample terraform.tfvars
```

## Edit `terraform.tfvars`

Amend the values for

* `access_key`
* `secret_key`
* `region`
* `domain`
* `hosted_zone_id`
* `domain`
* `acme_mail`
* `kubeconfig_path`


## Create

```
./create-certmanager.sh
```

This script will perform a helm deploy of this [chart](https://hub.helm.sh/charts/jetstack/cert-manager).

## Destroy

To tear it down

```
./destroy-certmanager.sh
```

## Troubleshooting

If you notice that you're still challenged on visiting a website in your browser

```
Your connection is not private
Attackers might be trying to steal your information from janky.one.me
```

You may want to verify that the cluster issuer was installed correctly and that the certificate is truly in ready state

```
kubectl get clusterissuers -A
kubectl get certificates -A -o wide
```

Try re-running the `create-certmanager.sh` script.
