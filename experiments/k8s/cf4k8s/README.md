# Terraform for installing cf-for-k8s

Deploy the Cloud Foundry Application Runtime on Kubernetes.

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
* `registry_password`
* `kubeconfig_path`

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
enable_automount_service_account_token: true
metrics_server_prefer_internal_kubelet_address: true
use_first_party_jwt_tokens: true
```

## Install

```
./create-cf4k8s.sh <iaas> <base_domain>
```
> Set `iaas` to be one of [ amazon, azure, gcp ] and set `base_domain` to be the same value as defined in `terraform.tfvars`


## Remove

```
./destroy-cf4k8s.sh <iaas>
```
> Set `iaas` to be one of [ amazon, azure, gcp ]