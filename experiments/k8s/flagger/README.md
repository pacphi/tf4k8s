# Terraform for installing Weaveworks Flagger

Uses [helm](https://www.terraform.io/docs/providers/helm/index.html) Terraform provider to install [Flagger](https://docs.flagger.app) with support for Contour canary deployments.  Employs this helm [chart](https://hub.helm.sh/charts/flagger/flagger).

Flagger is a Kubernetes operator that automates the promotion of canary deployments using a routing provider (e.g., Contour) for traffic shifting and Prometheus metrics for canary analysis. The canary analysis can be extended with webhooks for running system integration/acceptance tests, load tests, or any other custom validation.

Flagger implements a control loop that gradually shifts traffic to the canary while measuring key performance indicators like HTTP requests success rate, requests average duration and pods health. Based on analysis of the KPIs a canary is promoted or aborted, and the analysis result may be published to Slack or MS Teams.

Flagger can be configured with Kubernetes custom resources and is compatible with any CI/CD solutions made for Kubernetes.

Assumes

* you have already provisioned a cluster
* you have configured [Contour](../k8s/contour) for ingress

## Copy sample configuration

```
cp terraform.tfvars.sample terraform.tfvars
```

## Edit `terraform.tfvars`

Amend the value for

* `kubeconfig_path`

## Install

```
./create-flagger.sh
```

## Use

Follow the tutorial [here](https://docs.flagger.app/tutorials/contour-progressive-delivery#bootstrap) to learn how Flagger facilitates progressive delivery.

## Remove

```
./destroy-flagger.sh
```
