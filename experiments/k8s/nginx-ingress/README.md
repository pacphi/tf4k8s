# Terraform for configuring NGINX Ingress integrated with External DNS

Uses [k14s](https://github.com/k14s/terraform-provider-k14s) Terraform provider to configure [nginx ingress](https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/nginx-ingress.md#deploy-the-nginx-ingress-controller).

Starts with the assumption that you have already provisioned a cluster.

Make a copy of `nginx-ingress.tf.sample` and rename it

```
cp nginx-ingress.tf.sample nginx-ingress.tf
```

Edit `nginx-ingress.tf` and amend the values for

* `kubeconfig_path`

```
./create-nginx-ingress.sh
```

To tear it down

```
./destroy-nginx-ingress.sh
```
