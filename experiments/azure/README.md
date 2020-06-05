# Microsoft Azure Terraform Experiments

Here we'll use [az](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) and a minimal complement of Terraform [providers](https://www.terraform.io/docs/providers/index.html) to

* Create a service principal
* Provision cloud resources (like DNS)
* Create a simple AKS cluster
* Install additional Kubernetes infrastructure modules (like cert-manager, nginx-ingress, external-dns)
* Install Harbor
* Install [cf-for-k8s](https://github.com/cloudfoundry/cf-for-k8s)

and much more.

## The basics

* Install [prerequisite software](../../bom)
* [Setup a service principal](iam)
* [Setup DNS](dns)
* [Provision cluster](cluster)
* [Install cert-manager](certmanager)
* [Install nginx-ingress](../k8s/nginx-ingress)
* [Install external-dns](external-dns)
* [Install Harbor](../k8s/harbor)
* [Install cf-for-k8s](../k8s/cf4k8s)

## For additional exploration

* [Install VMWare Tanzu Application Service for Kubernetes](../k8s/tas4k8s)
* [Create an Azure storage container](blobstore)