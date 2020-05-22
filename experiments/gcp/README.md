# Google Cloud Platform Terraform Experiments

Here we'll use [gcloud](https://cloud.google.com/sdk/gcloud) and a minimal complement of Terraform [providers](https://www.terraform.io/docs/providers/index.html) to

* Create a service account with appropriate role and permissions
* Provision cloud resources (like DNS)
* Create a simple GKE cluster
* Install additional Kubernetes infrastructure modules (like cert-manager, nginx-ingress, external-dns)
* Install Harbor
* Install [cf-for-k8s](https://github.com/cloudfoundry/cf-for-k8s)

and much more.

## The basics

* Install [prerequisite software](../../bom)
* [Setup a service account](iam)
* [Setup DNS](dns)
* [Provision cluster](cluster)
* [Install cert-manager](certmanager)
* [Install nginx-ingress](../k8s/nginx-ingress)
* [Install external-dns](external-dns)
* [Install Harbor](../k8s/harbor)
* [Install cf-for-k8s](../k8s/cf4k8s)

## For additional exploration

* [Install VMWare Tanzu Application Service for Kubernetes](../k8s/tas4k8s)