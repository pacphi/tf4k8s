# Terraform for installing VMware Tanzu Application Service for Kubernetes

Deploy a commercially supported beta of the Cloud Foundry Application Runtime on Kubernetes.

Assumes:

* You have a cloud account on Azure, AWS, or Google
* You have already provisioned a cluster that meets [minimum operating requirements](https://github.com/cloudfoundry/cf-for-k8s/blob/master/docs/deploy.md#kubernetes-cluster-requirements)
* You have registered a domain (perhaps via [managed DNS](https://www.thousandeyes.com/learning/techtorials/managed-dns))
* You have installed 
  * [cert-manager](https://github.com/jetstack/cert-manager#cert-manager)
  * [nginx-ingress-controller](https://bitnami.com/stack/nginx-ingress-controller/helm) or [Contour](https://projectcontour.io/getting-started/)
  * [external-dns](https://github.com/kubernetes-sigs/external-dns#externaldns)
  * [Harbor](https://goharbor.io/docs/2.0.0/install-config/), [JFrog Container Registry](https://www.jfrog.com/confluence/display/JCR6X/Helm+Registry), [Azure Container Registry](https://azure.microsoft.com/en-us/services/container-registry/#overview), or [Google Container Registry](https://cloud.google.com/container-registry/docs/quickstart)
* You have credentials for 
  * [Tanzu Network](https://network.pivotal.io/)
  * your container registry
  * your cluster (i.e., ~/.kube/config)

> Review the [experiments](..) directory for help addressing these pre-requisites before getting started.

## Copy sample configuration

```
cp terraform.tfvars.sample terraform.tfvars
```

## Edit `terraform.tfvars`

Amend the values for

* `base_domain`
* `registry_domain`
* `repository_prefix`
* `registry_username`
* `registry_password`
* `pivnet_username`
* `pivnet_password`
* `kubeconfig_path`

Install VMware Tanzu Application Service for Kubernetes

## Create a new file named `iaas.auto.tfvars`

Add and (of course) amend values for

```
email = ...
domain = ...
```

then depending upon your IaaS, uncomment and amend values for blocks of configuration as follows

### Amazon

```
dns_zone_id = ...
```

### Azure

```
client_id = ...
client_secret = ...
tenant_id = ...
subscription_id = ...
resource_group_name = ...
```

### GCP

```
project = ...
```

## on Kind

If you're deploying [locally](https://github.com/cloudfoundry/cf-for-k8s/blob/master/docs/deploy-local.md#deploying-cf-for-k8s-locally) to a [kind](https://kind.sigs.k8s.io/docs/user/quick-start/) cluster then you must set the following additional variables

```
remove_resource_requirements = true
add_metrics_server_components = true
enable_load_balancer = false
enable_automount_service_account_token = true
metrics_server_prefer_internal_kubelet_address = true
use_first_party_jwt = true
```

## Preflight checklist

### Where are the install images sourced?

If you intend to install a pre-release build of VMware Tanzu Application Service for Kubernetes, then edit `terraform.tfvars` so that it includes:

```
pivnet_registry_hostname = "dev.registry.pivotal.io"
```
> Note `pivnet_username` must be a user group member in order to pull images from this registry.

Verify and/or update the values for `TAS4K8S_VERSION` and `TAS4K8S_PRODUCT_FILE_ID` in [download-tas4k8s.sh](../../../ytt-libs/tas4k8s/scripts/download-tas4k8s.sh).  (If the `TAS4K8S_VERSION` variable's value in that script includes `.build`, you're using a pre-release build).


### How may I influence the number of replicas available for each resource?

You may have limited available compute capacity or you may want to scale out the deployment footprint to accommodate increased demand.

Before you invoke the `create-tas4k8s.sh` script, create a new file named `resource-replicas.yml`, and place it in a new subdirectory underneath the [ytt-libs/tas4k8s](https://github.com/pacphi/tf4k8s/tree/master/ytt-libs/tas4k8s) directory named `config-optional`.  Paste and save the following content into it

```
#@data/values
---
resources:
  istiod:
    replicas: 1
  usage-service-server-deployment:
    replicas: 1
  uaa:
    replicas: 1
  search-server-deployment:
    replicas: 1
  routecontroller:
    replicas: 1
  metric-proxy:
    replicas: 1
  webhook-server:
    replicas: 1
  inject-ca-certs-into-running-apps:
    replicas: 1
  cf-api-server:
    replicas: 1
  apps-manager-js:
    replicas: 1
```

## Install

```
./create-tas4k8s.sh <iaas> <tanzu-network-api-token>
```
> Set `iaas` to be one of [ amazon, azure, gcp ] and set`tanzu-network-api-token` to be a valid API token for an [account](https://network.pivotal.io/users/dashboard/edit-profile) on the [Tanzu Network](https://network.pivotal.io)

## Usage

```
terraform output
```
> Reveals credentials for authentication

### CLI

```
cf api {tas_api_endpoint}
cf auth admin {tas_admin_password}
```

### Apps Manager

Visit 

```
https://console.tas.{domain}
```

in your favorite browser.

The credentials to login are the same as the ones used to authenticate the `{tas_api_endpoint}`.


## Remove

```
./destroy-tas4k8s.sh <iaas>
```
> Set `iaas` to be one of [ amazon, azure, gcp ]
