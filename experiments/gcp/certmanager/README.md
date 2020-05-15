# Terraform for creating a Certificate Manager

This sample leverages [cert-manager](https://github.com/jetstack/cert-manager) to automate the management and issuance of TLS certificates from [Let's Encrypt](https://letsencrypt.org).

Starts with the assumption that you have already provisioned a GKE cluster.

Make a copy of `certmanager.tf.sample` and rename it

```
cp certmanager.tf.sample certmanager.tf
```

Edit `certmanager.tf` and amend the values for

* `project`
* `domain`
* `environment_name`
* `acme_mail`
* `dns_zone_name`
* `gke_name`
* `gcp_zone`
* `credentials`
* `kubeconfig_path`

This script will perform a helm deploy of this [chart](https://hub.helm.sh/charts/jetstack/cert-manager).

```
./create-certmanager.sh
```

To tear it down

```
./destroy-certmanager.sh
```
