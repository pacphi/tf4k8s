# Terraform for installing Tanzu Service Manager (TSMGR)

Uses [kubernetes](https://www.terraform.io/docs/providers/kubernetes/index.html), [helm](https://www.terraform.io/docs/providers/helm/index.html) and [k14s](https://github.com/k14s/terraform-provider-k14s) Terraform providers to install [TSMGR](https://docs.pivotal.io/ksm/0-11/index.html).

TSMGR enables operators to provide app developers with access to services through the `cf marketplace`. 

Starts with the assumption that you have already provisioned a cluster.

## Edit `terraform.tfvars`

Amend the values for

* `domain`
* `ingress`
* `kubeconfig_path`

## Install CLI

```
./install-cli-{os}.sh {tanzu_network_api_token}
```
> Replace `{os}` with either: `macos` or `linux` and `{tanzu_network_api_token}` with a valid VMWare Tanzu Network [API Token](https://network.pivotal.io/users/dashboard/edit-profile)

## Fetch TSMGR container images

```
./fetch-tsmgr-images.sh {tanzu_network_username} {tanzu_network_password}
```
> Replace `{tanzu_network_username}` and `{tanzu_network_password}` with credentials you use to authenticate to VMWare Tanzu Network

## Configure TSMGR prerequisites

```
./configure-tsmgr-prerequisites.sh {harbor_domain} {harbor_username} {harbor_password} {s3_endpoint} {s3_access_key} {s3_secret_key}
```

## Fetch Helm chart

```
./fetch-tsmgr-helm-chart.sh {tanzu_network_api_token}
```
> Replace `{tanzu_network_api_token}` with a valid VMWare Tanzu Network [API Token](https://network.pivotal.io/users/dashboard/edit-profile)

## Install Helm chart

```
./install-tsmgr.sh
```

## Use

If you've survived the gauntlet of installation, your next steps are to configure, package, publish and expose service offerings. 

Have a look at: 

* [Using Tanzu Service Manager](https://docs.pivotal.io/ksm/0-11/using.html)
* [About Service Offerings](https://docs.pivotal.io/ksm/0-11/about-offer.html)
* [Preparing a Service Offering](https://docs.pivotal.io/ksm/0-11/prepare-offer.html)
* [Managing Kubernetes Clusters for Tanzu Service Manager](https://docs.pivotal.io/ksm/0-11/managing-clusters.html)
* [Troubleshooting](https://docs.pivotal.io/ksm/0-11/troubleshoot.html)

## Uninstall Helm chart

```
./uninstall-tsmgr.sh
```