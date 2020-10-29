# Terraform for Provisioning a TKG Management cluster in Azure

Uses Terraform to install Tanzu Kubernetes Grid management cluster in Azure.

See [Deploy Management Clusters to Microsoft Azure with the CLI](https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.2/vmware-tanzu-kubernetes-grid-12/GUID-mgmt-clusters-azure-cli.html)

Assumes:

* You have an Azure service principal with the Administrator role
* You have downloaded and installed the tkg CLI
* You have [registered an SSH Public Key](https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.2/vmware-tanzu-kubernetes-grid-12/GUID-mgmt-clusters-azure.html#ssh-key)
* You have accepted the license for the base Kubernetes version and machine OS
  * To do this, execute `az vm image terms accept --publisher vmware-inc --offer tkg-capi --plan k8s-1dot19dot1-ubuntu-1804`

## Copy sample configuration

```
cp terraform.tfvars.sample terraform.tfvars
```
   
## Edit `terraform.tfvars`

Amend the values for

* `environment`
* `path_to_tkg_config_yaml`
* `az_subscription_id`
* `az_client_id`
* `az_tenant_id`
* `az_client_secret`
* `az_resource_group_name`
* `path_to_az_ssh_public_key`

> There are other variable values you can adjust. Peek at [main.tf](main.tf) to see what's available.

## Provision

```
./create-mgmt-cluster.sh
```

> If you chose the `dev` plan the installation normally completes in less than 10 minutes.

## Destroy

```
./destroy-mgmt-cluster.sh
```

## Troubleshooting

### Sleuthing cluster-api error indicators in bootstrap cluster

```
kubectl describe cluster-api -A --kubeconfig ~/.kube-tkg/tmp/{config}
```
> Look for occurrences of "Error" or "Exception"

### Removing the bootstrap cluster

The bootstrap cluster runs with [kind](https://kind.sigs.k8s.io/docs/user/quick-start/).  

If you have kind installed you can run 

```
kind get clusters
```

then use the name of the cluster to delete it

```
kind delete clusters {name}
```

### Starting from a clean slate

If you want to get back to clean initial state execute the following sequence of commands.

```
rm -Rf ~/.tkg                                       ## Destroys all TKG configuration 
rm -Rf ~/.kube                                      ## Destroys all Kubernetes cluster context
rm -Rf ~/.kube-tkg                                  ## Destroys all TKG bootstrap context
docker container prune                              ## Prunes all unused containers, reclaiming disk space
docker volume prune                                 ## Prunes all unused volumes, reclaiming disk space
docker rmi registry.tkg.vmware.run/kind/node:{tag}  ## Removes the container image used to provision TKG clusters
```

### More tips

Consult the VMWare Tanzu Kubernetes Grid [troubleshooting documentation](https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.2/vmware-tanzu-kubernetes-grid-12/GUID-troubleshooting-tkg-tips.html)