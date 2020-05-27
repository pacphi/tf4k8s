# Terraform for Kubernetes

An exploration into the use of Terraform to provision Kubernetes clusters on popular IaaS.

## Organization

* `bom`
  * Bill of materials; what do you need to get started?
* `experiments`
  * Progressively build out a platform to deliver software delivery agility underpinned by Kubernetes
* `modules`
  * Building blocks to be composed as you see fit
* `ytt-libs`
  * yaml; templates and miscellaneous scripts

## Currently Supported IaaS

- [x] [Google Cloud Platform (GKE)](experiments/gcp)
- [x] [Microsoft Azure (AKS)](experiments/azure)

## Basics

- [x] Create an IAM service account
- [x] Add DNS Zone management
- [x] Add Certificate management
- [x] Add Ingress and External DNS

## Installable modules

- [x] Harbor
- [x] cf-for-k8s
- [x] VMWare Tanzu Application Service for Kubernetes

## Roadmap

### Cloud Foundry

#### Administration

- [ ] Stratos

#### Open Service Broker-compatible API servers

Provision managed services in a public cloud and bind them to applications

- [ ] [Google Cloud Platform](https://github.com/GoogleCloudPlatform/gcp-service-broker)
- [ ] [Amazon Web Services](https://github.com/awslabs/aws-servicebroker)
- [ ] [Microsoft Azure](https://github.com/Azure/open-service-broker-azure)

### CI/CD

- [ ] Gitlab
- [x] VMWare Tanzu Build Service
- [ ] Concourse
- [ ] Spinnaker

### Monitoring

- [ ] Elasticsearch, Logstash, Kibana
- [ ] Grafana
- [ ] Tanzu Observability

### Stream Processing

- [ ] Kafka
- [ ] Spring Cloud Dataflow

### Policy Management

- [ ] Tanzu Mission Control

### IaaS Support

- [ ] vSphere 7 with Kubernetes (Tanzu Kubernetes Grid)
- [ ] Amazon Web Service (EKS)
