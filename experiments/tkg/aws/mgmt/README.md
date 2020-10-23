# Terraform for Provisioning a TKG Management cluster in AWS

Uses Terraform to install Tanzu Kubernetes Grid management cluster in AWS.

See [Deploy Management Clusters to Amazon EC2 with the CLI](https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.2/vmware-tanzu-kubernetes-grid-12/GUID-mgmt-clusters-aws-cli.html)

Assumes:

* You have an AWS account with the Administrator role
* You have downloaded and installed the tkg CLI
* You have [registered an SSH Public Key](https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.2/vmware-tanzu-kubernetes-grid-12/GUID-mgmt-clusters-aws.html#register-ssh)

## Edit `terraform.tfvars`

Amend the values for

* `environment`
* `aws_secret_key_id`
* `aws_secret_access_key`
* `aws_ssh_key_name`
* `path_to_tkg_config_yaml`

> There are other variable values you can adjust. Peek at [main.tf](main.tf) to see what's available.

## Provision

```
./create-mgmt-cluster.sh
```

## Destroy

```
./destroy-mgmt-cluster.sh
```

## Troubleshooting

### Deleting the management cluster

With tkg 1.2, attempting to delete the management cluster fails.  

Here's the work-around...

* Download and install the 0.5.5 release of [clusterawsadm](https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/tag/v0.5.5).  (Pick a binary suitable for the operating system that hosts your development or continuous integration environment.).
* Export the missing environment variable with `export AWS_B64ENCODED_CREDENTIALS=$(clusterawsadm alpha bootstrap encode-aws-credentials)`
* Re-attempt to delete the management cluster with `tkg delete management-cluster {tkg_mgmt_cluster_name} --config {path_to_config_yaml_file}`

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