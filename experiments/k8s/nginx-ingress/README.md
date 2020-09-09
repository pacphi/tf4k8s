# Terraform for configuring NGINX Ingress

Uses [helm](https://www.terraform.io/docs/providers/helm/index.html) Terraform provider to configure [nginx ingress](https://hub.helm.sh/charts/bitnami/nginx-ingress-controller).

Starts with the assumption that you have already provisioned a cluster.

## Edit `terraform.tfvars`

Amend the values for

* `kubeconfig_path`

### Enabling SSL Passthrough

If you wish to enable [SSL Passthrough](https://kubernetes.github.io/ingress-nginx/user-guide/tls/#ssl-passthrough), you should set

```
extra_args_key = "enable-ssl-passthrough"
extra_args_value = "true"
```

> You'll want to do this if you intend to install [Argo CD](../argo-cd)

## Install

```
./create-nginx-ingress.sh
```

## Remove

```
./destroy-nginx-ingress.sh
```
