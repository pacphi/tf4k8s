# Terraform for Kubernetes

An exploration into the use of Terraform to provision Kubernetes clusters on any IaaS. 

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

- [x] [Google Cloud Platform](experiments/gcp)

## Basics

- [x] Create an IAM service account
- [x] DNS Zone management
- [x] Certificate management
- [x] Ingress and External DNS

## Installable modules

- [x] Harbor
- [x] cf-for-k8s
- [x] VMWare Tanzu Application Service for Kubernetes

## Roadmap

### Administration

- [ ] Stratos

### CI/CD

- [ ] Gitlab
- [ ] VMWare Tanzu Build Service
- [ ] Concourse
- [ ] Spinnaker

### Monitoring

- [ ] Elasticsearch, Logstash, Kibana
- [ ] Grafana

### Stream Processing

- [ ] Kafka
- [ ] Spring Cloud Dataflow

## Integrations

- [ ] Tanzu Observability
- [ ] Tanzu Mission Control


### IaaS Support

- [ ] vSphere 7 with Kubernetes (Tanzu Kubernetes Grid)
- [ ] Amazon Web Service (EKS)
- [ ] Microsoft Azure (AKS)
