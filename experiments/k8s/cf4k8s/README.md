# Terraform for installing cf-for-k8s

// TODO Add description

Starts with the assumption that you have already provisioned a cluster.

Make a copy of `cf4k8s.tf.sample` and rename it

```
cp cf4k8s.tf.sample cf4k8s.tf
```

Edit `cf4k8s.tf` and amend the values for

* `project`
* `acme_email` = "<valid-email-address>"`
* `iaas`
* `registry_domain`
* `registry_repository`
* `registry_password`
* `kubeconfig_path`

Install cf-for-k8s 

```
./create-cf4k8s.sh
```

To tear it down

```
./destroy-cf4k8s.sh
```
