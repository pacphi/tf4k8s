# Terraform for installing Argo CD

Uses [kubernetes](https://www.terraform.io/docs/providers/kubernetes/index.html), [helm](https://www.terraform.io/docs/providers/helm/index.html) and [k14s](https://github.com/k14s/terraform-provider-k14s) Terraform providers to install [Argo CD](https://argoproj.github.io/argo-cd/).  This community maintained [chart](https://github.com/argoproj/argo-helm/tree/master/charts/argo-cd) is employed.

Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes.

Starts with the assumption that you have already provisioned a cluster.

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

At this point it's up to you whether or not you'd like to follow the rest of the steps outlined in the [Getting Started](https://argoproj.github.io/argo-cd/getting_started/#creating-apps-via-ui) guide, or choose your own path forward.

## Teardown

Teardown your installation with

```
./destroy-argocd.sh
```


## Known Issue

On login you will be challenged with the following message

```
WARNING: server certificate had error: x509: certificate is valid for localhost, argocd-server, argocd-server.argocd, argocd-server.argocd.svc, argocd-server.argocd.svc.cluster.local, not ... Proceed insecurely (y/n)?
```

To fix, we'll need to update the Helm chart configuration to support certificates issued by cert-manager.