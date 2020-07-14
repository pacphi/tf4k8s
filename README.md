# Terraform for Kubernetes

An exploration into the use of Terraform to provision Kubernetes clusters on popular IaaS.

## Vision

Launch a relatively comprehensive end-to-end demo environment for discussion purposes and/or hands-on workshops in under an hour.

## Getting Started

Choose your own adventure on one of the following cloud providers

- [x] [Google Cloud Platform (GKE)](experiments/gcp)
- [x] [Microsoft Azure (AKS)](experiments/azure)
- [x] [Amazon Web Service (EKS)](experiments/amazon)

Manage clusters in your own data-center with

- [ ] VMWare vSphere 7 with Kubernetes (VMWare Tanzu Kubernetes Grid)

Or provision new / attach existing Kubernetes clusters via

- [ ] VMWare Tanzu Mission Control

## Current experiments

- [x] Identity management
- [x] Add DNS Zone management
- [x] Add Certificate management
- [x] Add Ingress and External DNS
- [x] Install a registry like [ACR](experiments/azure/registry), [GCR](experiments/gcp/registry), [Harbor](experiments/k8s/harbor) or [JCR](experiments/k8s/jcr)
- [x] Install [VMWare Tanzu Build Service](experiments/k8s/tbs)
- [x] Install [cf-for-k8s](experiments/k8s/cf4k8s)
- [x] Install [VMWare Tanzu Application Service for Kubernetes](experiments/k8s/tas4k8s)
- [x] Install [Pivotal Cloud Service Broker](experiments/k8s/pivotal-csb)
- [x] Install [Stratos](experiments/k8s/stratos)
- [x] Install [Loki Stack](experiments/k8s/loki-stack)
- [x] Install [EFK Stack](experiments/k8s/efk-stack)
- [x] Integrate a cloud provider's blobstore or install [Minio](experiments/k8s/minio)
- [x] Integrate [VMware Tanzu Observability](experiments/k8s/wavefront)
- [x] Enable continuous deployment with [Argo CD](experiments/k8s/argo-cd) or [Tekton](experiments/k8s/tekton)

## Organization

Sub-directories of this repository contain

* `bom`
  * Bill of materials; what do you need to get started?
* `experiments`
  * Progressively build out a platform to deliver software delivery agility underpinned by Kubernetes
* `modules`
  * Building blocks to be composed as you see fit
* `ytt-libs`
  * YAML-based templates consumed by [ytt](https://get-ytt.io) then deployed with [kapp](https://get-kapp.io)


## Roadmap

Above-mentioned experiments will evolve to include automating base configuration and installation of an additional complement of capabilities/components aimed at modeling a modern enterprise software factory / product delivery supply chain.

### Cloud Foundry

#### Administration

- [x] Stratos

#### Open Service Broker-compatible API servers

Provision managed services in a public cloud and bind them to applications

- [ ] [Google Cloud Platform](https://github.com/GoogleCloudPlatform/gcp-service-broker)
- [ ] [Amazon Web Services](https://github.com/awslabs/aws-servicebroker)
- [ ] [Microsoft Azure](https://github.com/Azure/open-service-broker-azure)
- [x] [Open Service Broker for Cloud Platform (GCP, Azure, AWS)](https://github.com/pivotal/cloud-service-broker)

### CI/CD

- [x] Argo CD
- [ ] Jenkins
- [ ] Gitlab
- [x] VMWare Tanzu Build Service
- [ ] Concourse
- [ ] Spinnaker
- [x] Tekton

#### Reference Pipelines

// TBD

### Logging/Monitoring/Metrics

- [x] [FluentBit](https://docs.fluentbit.io/manual/installation/kubernetes)
- [x] Elasticsearch, Kibana
- [x] Prometheus
- [x] Grafana
- [x] VMWare Tanzu Observability

### Cluster/Policy Management

- [ ] VMWare Tanzu Mission Control

### Additional "building blocks" and maintenance

- [x] [Contour](https://github.com/projectcontour/contour)
- [x] Registries: [ACR](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-intro), [GCR](https://cloud.google.com/container-registry), [JFrog Container Registry](https://github.com/jfrog/charts/tree/master/stable/artifactory-jcr)
- [ ] [Velero](https://velero.io)

### Services

#### Blob stores

- [x] Minio
- [x] Amazon S3
- [x] Google Cloud Storage Bucket
- [x] Azure Blob Storage

#### Stream Processing

- [ ] Kafka
- [ ] Spring Cloud Dataflow

#### Caching

- [ ] Redis

#### Databases

- [ ] Mongo
- [ ] MySQL
- [ ] Postgres

### Cloud Native Samples

#### Microservices

- [ ] Java with Spring Boot and Spring Cloud
- [ ] DotNet Core with Steeltoe
- [ ] Python with Django and Flask
