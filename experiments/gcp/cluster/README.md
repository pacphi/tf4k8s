# Terraform a Simple GKE Cluster

Based on the following Terraform Registry module [hajowieland/k8s/google](https://registry.terraform.io/modules/hajowieland/k8s/google/1.1.1)


If the account you are using has the IAM role `roles/resourcemanager/projectCreator` role assigned or has the `resourcemanager.projects.create` permission, then execute

```
./bootstrap.sh
```

Otherwise, execute

```
./bootstrap.sh <project-id>
```

Make a copy of `simple-cluster.tf.sample` and rename it

```
cp simple-cluster.tf.sample simple-cluster.tf
```

Edit `simple-cluster.tf` and amend the values for

* `gcp_project`
* `gcp_region`
* `gke_service_account`

> You're also free to update any other input variable value

Create the cluster

```
./create-cluster.sh <project-id>
```
> When you do not want to create a new project (or don't have permissions to create one to house the service account and cluster)

```
./create-cluster.sh
```
> When you want to create a new project to house the service account and cluster

List available clusters

```
./list-clusters.sh
```

Use the name and location of the cluster you just created to update `kubeconfig` and set the current context for `kubectl`

```
./set-kubectl-context.sh <gke-cluster-name> <gke-zone>
```

Validate you have some pods running

```
kubectl get pods -A
```

And if you want to tear everything down

```
./teardown.sh
```
> When you don't want to delete the project (and subsequently delete all cloud objects within it)

```
./teardown.sh <project-id>
```
> Nuke the project and everything in it