# Terraform for Kubernetes

An exploration into the use of Terraform to provision Kubernetes clusters on popular IaaS.

## Vision

Launch a relatively comprehensive end-to-end demo environment for discussion purposes and/or hands-on workshops in under an hour.

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

## Supported IaaS

Get started with...

- [x] [Google Cloud Platform (GKE)](experiments/gcp)
- [x] [Microsoft Azure (AKS)](experiments/azure)
- [x] [Amazon Web Service (EKS)](experiments/amazon)
- [ ] VMWare Tanzu Mission Control
- [ ] vSphere 7 with Kubernetes (Tanzu Kubernetes Grid)

## Current experiments

- [x] Identity management
- [x] Add DNS Zone management
- [x] Add Certificate management
- [x] Add Ingress and External DNS
- [x] Install [Harbor](experiments/k8s/harbor)
- [x] Install [cf-for-k8s](experiments/k8s/cf4k8s)
- [x] Install [VMWare Tanzu Application Service for Kubernetes](experiments/k8s/tas4k8s)
- [x] Install [VMWare Tanzu Build Service](experiments/k8s/tbs)
- [x] Install [Loki Stack](experiments/k8s/loki-stack)
- [x] Integrate [VMware Tanzu Observability](experiments/k8s/wavefront)

## Roadmap

Above-mentioned experiments will evolve to include automating base configuration and installation of an additional complement of capabilities/components aimed at modeling a modern enterprise software factory / product delivery supply chain.

### Cloud Foundry

#### Administration

- [ ] Stratos

#### Open Service Broker-compatible API servers

Provision managed services in a public cloud and bind them to applications

- [ ] [Google Cloud Platform](https://github.com/GoogleCloudPlatform/gcp-service-broker)
- [ ] [Amazon Web Services](https://github.com/awslabs/aws-servicebroker)
- [ ] [Microsoft Azure](https://github.com/Azure/open-service-broker-azure)
- [ ] [Open Service Broker for Cloud Platform (GCP, Azure, AWS)](https://github.com/pivotal/cloud-service-broker)

### CI/CD

- [ ] Jenkins
- [ ] Gitlab
- [x] VMWare Tanzu Build Service
- [ ] Concourse
- [ ] Spinnaker
- [ ] Tekton

#### Reference Pipelines

// TBD

### Logging/Monitoring/Metrics

- [x] [FluentBit](https://docs.fluentbit.io/manual/installation/kubernetes)
- [ ] Elasticsearch, Logstash, Kibana
- [x] Prometheus
- [x] Grafana
- [x] VMWare Tanzu Observability

### Cluster/Policy Management

- [ ] VMWare Tanzu Mission Control

### Additional "building blocks" and maintenance

- [ ] [Contour](https://github.com/projectcontour/contour)
- [ ] Registries: [ACR](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-intro), [ECR](https://aws.amazon.com/ecr/getting-started/), [GCR](https://cloud.google.com/container-registry), [Artifactory](https://hub.helm.sh/charts?q=artifactory)
- [ ] [Velero](https://velero.io)

### Services

#### Stream Processing

- [ ] Kafka
- [ ] Spring Cloud Dataflow

#### Caching

- [ ] Redis

#### Databases

- [ ] Mongo

### Cloud Native Samples

#### Microservices

- [ ] Java with Spring Boot and Spring Cloud
- [ ] DotNet Core with Steeltoe
- [ ] Python with Django and Flask
