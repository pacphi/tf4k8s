# Terraform for Provisioning a TKG Workload cluster in Azure

Uses Terraform to install Tanzu Kubernetes Grid workload cluster in Azure.

See [Deploying Tanzu Kubernetes Clusters and Managing their Lifecycle](https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.2/vmware-tanzu-kubernetes-grid-12/GUID-tanzu-k8s-clusters-create.html#deploy)

Assumes:

* You have an Azure service principal with the Administrator role
* You have downloaded and installed the tkg CLI 
* You have already [provisioned a TKG management cluster](../mgmt/README.md)

## Edit `terraform.tfvars`

Amend the values for

* `environment`
* `path_to_tkg_config_yaml`

> There are other variable values you can adjust. Peek at [main.tf](main.tf) to see what's available.

## Provision

```
./create-workload-cluster.sh
```

## Destroy

```
./destroy-workload-cluster.sh
```
