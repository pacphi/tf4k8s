# Terraform for creating a Certificate Manager

This sample leverages [cert-manager](https://github.com/jetstack/cert-manager) to automate the management and issuance of TLS certificates from [Let's Encrypt](https://letsencrypt.org).

Starts with the assumption that you have already provisioned an AKS cluster.

Edit `terraform.tfvars` and amend the values for

* `az_subscription_id`
* `az_client_id`
* `az_client_secret`
* `az_tenant_id`
* `cluster_issuer_resource_group`
* `domain`
* `acme_mail`
* `kubeconfig_path`

This script will perform a helm deploy of this [chart](https://hub.helm.sh/charts/jetstack/cert-manager).

```
./create-certmanager.sh
```

To tear it down

```
./destroy-certmanager.sh
```

## Troubleshooting

If you notice that you're challenged on visiting a website in your browser

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