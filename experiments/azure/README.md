# Microsoft Azure Terraform Experiments

Here we'll use [az](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) and a minimal complement of Terraform [providers](https://www.terraform.io/docs/providers/index.html) to

* Create a service principal
* Provision cloud resources (like DNS)
* Create a simple AKS cluster
* Install additional Kubernetes infrastructure modules (like cert-manager, nginx-ingress, external-dns)
* Install a container registry
* Install [cf-for-k8s](https://github.com/cloudfoundry/cf-for-k8s)

and much more.

## The basics

* Install [prerequisite software](../../bom)
* [Setup a service principal](iam)
* [Setup DNS](dns)
* [Provision cluster](cluster)
* [Install cert-manager](certmanager)
* [Install nginx-ingress](../k8s/nginx-ingress) or [Contour](../k8s/contour)
* [Install external-dns](external-dns)
* Install a container registry like [ACR](registry), [Harbor](../k8s/harbor) or [JCR](../k8s/jcr)
* [Install cf-for-k8s](../k8s/cf4k8s)

## For additional exploration

* [Install VMWare Tanzu Application Service for Kubernetes](../k8s/tas4k8s)
* [Create an Azure storage container](blobstore)
* [Install Pivotal Cloud Service Broker](../k8s/pivotal-csb)
* [Install Stratos](../k8s/stratos)
* Install a continuous deployment engine like [ArgoCD](../k8s/argo-cd) or [Tekton](../k8s/tekton)
* Enable canary deployments with [Flagger](../k8s/flagger)
* Integrate observability with a choice of [Wavefront](../k8s/wavefront), [EFK](../k8s/efk-stack) or [Loki](../k8s/loki-stack) stacks

