# Terraform for installing the Avi Operator

Operator used to deploy, manage and remove an instance of the AKO controller. This operator when deployed creates an instance of the AKO controller and installs all the relevant objects like:

* AKO StatefulSet
* ClusterRole and ClusterRoleBinding
* ConfigMap required for the AKO controller and other artifacts.


This sample makes use of this [chart](https://github.com/avinetworks/avi-helm-charts/blob/master/docs/AKO/install/operator.md).

Starts with the assumption that you have already provisioned a cluster.

## Copy sample configuration

```
cp terraform.tfvars.sample terraform.tfvars
```

## Edit `terraform.tfvars`

Amend the values for

* `avi_hostname`
* `avi_cluster_name`
* `avi_cni_plugin`
* `avi_controller_username`
* `avi_controller_password`
* `kubeconfig_path`

## Create

```
./create-avi-lb.sh
```

## Use

// TODO

## Destroy

To tear it down

```
./destroy-avi-lb.sh
```
