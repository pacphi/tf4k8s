# Terraform for installing Argo CD and Argo Rollouts

Uses [kubernetes](https://www.terraform.io/docs/providers/kubernetes/index.html), [helm](https://www.terraform.io/docs/providers/helm/index.html) and [k14s](https://github.com/k14s/terraform-provider-k14s) Terraform providers to install 

* [Argo CD](https://argoproj.github.io/argo-cd/).  
  * This community maintained [chart](https://github.com/argoproj/argo-helm/tree/master/charts/argo-cd) is employed.
* [Argo Rollouts](https://argoproj.github.io/argo-rollouts)
  * This community maintained [chart](https://github.com/argoproj/argo-helm/tree/master/charts/argo-rollouts) is employed.

Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes.

Argo Rollouts is a Kubernetes controller and set of CRDs which provide advanced deployment capabilities such as blue-green, canary, canary analysis, experimentation, and progressive delivery features to Kubernetes.

Assumes

* that you have already provisioned a cluster
* that you have installed and configured nginx-ingress with [SSL Passthrough](../nginx-ingress/README.md#enabling-ssl-passthrough)

## Copy sample configuration

```
cp terraform.tfvars.sample terraform.tfvars
```

## Edit `terraform.tfvars`

Amend the values for

* `domain`
* `kubeconfig_path`


## Install

```
./create-argocd.sh
```

## Login

```
argocd login argocd.<domain>
```

## Change password

```
argocd account update-password
```

## Visit the Argo CD user interface

Open your favorite browser and visit

```
https://argocd.<domain>
```

Login with your newly minted credentials.

At this point it's up to you whether or not you'd like to follow the rest of the steps outlined in the [Getting Started](https://argoproj.github.io/argo-cd/getting_started/#creating-apps-via-ui) guide or choose your own path forward.

Consult this [guide](https://argoproj.github.io/argo-cd/user-guide/private-repositories/) if you want to work with a private Git repository.

## Explore Argo Rollouts features

* [Getting Started](https://argoproj.github.io/argo-rollouts/getting-started/)
* [Migration](https://argoproj.github.io/argo-rollouts/migrating/) from Deployment to Rollout

### Deployment strategies

* [Blue-Green](https://argoproj.github.io/argo-rollouts/features/bluegreen/)
* [Canary](https://argoproj.github.io/argo-rollouts/features/canary/)

### Experiments

* Ephemeral [runs](https://argoproj.github.io/argo-rollouts/features/experiment/#how-does-it-work) of one or more ReplicaSets

### Analysis

* [Background Analysis](https://argoproj.github.io/argo-rollouts/features/analysis/#background-analysis)
* [Analysis with Multiple Templates](https://argoproj.github.io/argo-rollouts/features/analysis/#analysis-with-multiple-templates)
* [Wavefront Metrics](https://argoproj.github.io/argo-rollouts/features/analysis/#wavefront-metrics)

## Teardown

Teardown your installation with

```
./destroy-argocd.sh
```

## Roadmap

- [ ] Configure charts to allow for pulling images from a private registry
- [ ] Author sample rollouts
