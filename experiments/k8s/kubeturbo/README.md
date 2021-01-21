# Terraform for installing a Turbonomic

Kubeturbo leverages Turbonomic's patented analysis engine to provide visibility and control across the entire stack in order to assure the performance of running micro-services in Kubernetes Pods, as well as the efficiency of underlying infrastructure.

This experiment wraps the [Kubeturbo Operator](https://github.com/turbonomic/kubeturbo/tree/master/deploy/kubeturbo-operator) for Kubernetes.

Starts with the assumption that you have already provisioned a cluster.


## Copy sample configuration

```
cp terraform.tfvars.sample terraform.tfvars
```

## Edit `terraform.tfvars`

Amend the values for

* `turbo_username`
* `turbo_password`
* `turbo_server_url`
* `turbo_server_version`
* `k8s_cluster_name`
* `kubeturbo_operator_commit_hash`
  * Visit [turbonomic/kubeturbo](https://github.com/turbonomic/kubeturbo/tags) and consult commit hashes associated with tags if you want to update the default value
  * Should correspond to the `turbo_server_version`
* `kubeconfig_path`


## Create

```
./create-kubeturbo.sh
```

## Destroy

To tear it down

```
./destroy-kubeturbo.sh
```
