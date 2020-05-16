# Terraform for creating Harbor

// TODO Description

Make a copy of `harbor.tf.sample` and rename it

```
cp harbor.tf.sample harbor.tf
```

Edit `harbor.tf` and amend the values for

* `project`
* `credentials`
* `kubeconfig_path`
* `kubeconfig`

// TODO Description

```
./create-harbor.sh
```

To tear it down

```
./destroy-harbor.sh
```
