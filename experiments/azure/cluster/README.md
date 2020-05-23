# Terraform a Simple AKS Cluster

Based on the following Terraform [example](https://www.terraform.io/docs/providers/azurerm/r/kubernetes_cluster.htm).

Assumes a service account has been created with appropriate role and permissions to create a GKE cluster.

Edit `terraform.tfvars` and amend the values for

* `aks_resource_group`
* `enable_logs`
* `ssh_public_key`
* `az_subscription_id`
* `az_client_id`
* `az_client_secret`
* `az_tenant_id`
* `aks_region`
* `aks_name`
* `aks_nodes`
* `aks_node_type`
* `aks_pool_name`
* `aks_node_disk_size`

> You're also free to update any other input variable value

Create the cluster

```
./create-cluster.sh
```

List available clusters

```
./list-clusters.sh
```

Use the name and location of the cluster you just created to update `kubeconfig` and set the current context for `kubectl`

```
./set-kubectl-context.sh <aks-cluster-name> <azure-resource-group>
```

Validate you have some pods running

```
kubectl get pods -A
```

And if you want to tear down the cluster

```
./destroy-cluster.sh
```
