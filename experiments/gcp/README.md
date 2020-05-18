# Google Cloud Platform Terraform Experiments

Here we'll use [gcloud](https://cloud.google.com/sdk/gcloud) and a minimal complement of Terraform [providers](https://www.terraform.io/docs/providers/index.html) to

* Create a service account with appropriate role and permissions
* Provision cloud resources (like DNS)
* Create a simple GKE cluster 
* Install additional Kubernetes infrastructure modules (like cert-manager, nginx-ingress, external-dns)
* Install Harbor

and much more.

It makes sense to follow a path

* Install [prerequisite software](https://github.com/pacphi/tf4k8s/tree/master/bom)
* [Setup a service account](iam)
* [Setup DNS](dns)
* [Provision cluster](cluster)
* [Install cert-manager](certmanager)
* [Install nginx-ingress](../k8s/nginx-ingress)
* [Install external-dns](external-dns)
* [Install Harbor](../k8s/harbor)

Afterwards, you can choose your own adventure.