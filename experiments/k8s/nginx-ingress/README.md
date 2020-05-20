# Terraform for configuring NGINX Ingress integrated with External DNS

Uses [helm](https://www.terraform.io/docs/providers/helm/index.html) Terraform provider to configure [nginx ingress](https://kubernetes.github.io/ingress-nginx/).

Starts with the assumption that you have already provisioned a cluster.

Edit `terraform.tfvars` and amend the values for

* `kubeconfig_path`

```
./create-nginx-ingress.sh
```

To tear it down

```
./destroy-nginx-ingress.sh
```
