# Terraform for installing Gitea

What if you could host your own Git repository for source control? There's obviously several community options. Setting up Gitea seems like the least amount of fuss.

Uses [kubernetes](https://www.terraform.io/docs/providers/kubernetes/index.html), [helm](https://www.terraform.io/docs/providers/helm/index.html) and [k14s](https://github.com/k14s/terraform-provider-k14s) Terraform providers to install [Gitea](https://docs.gitea.io/en-us/).  

Employs John Felten's Helm [chart](https://github.com/jfelten/gitea-helm-chart). 

> Gitea is a painless self-hosted Git service. It is similar to GitHub, Bitbucket, and GitLab. Gitea is a fork of Gogs. See the Gitea Announcement blog post to read about the justification for a fork.

Assumes:

* you have already provisioned a cluster
* you're using nginx for Ingress

## Edit `terraform.tfvars`

Amend the values for

* `domain`
* `persistence_enabled`
* `persistence_storageclass`
* `kubeconfig_path`

## Install

```
./create-gitea.sh
```

## Remove

```
./destroy-gitea.sh
```
