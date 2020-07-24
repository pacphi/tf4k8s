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

## Use

On first visit to the site in your browser you should register the administrator account.  Click on `Register` link in the upper right-hand corner, scroll to the bottom of the dialog. Just beneath a section named `Optional Settings` is an expandable sub-section labeled `Administrator Account Settings`.  Type in a `username` that is not `admin` as this a reserved account.  Fill in the rest of the details and click the `Install Gitea` button.

You'll be automatically authenticated with those credentials and have the opportunity to update your profile.  Be sure to register a public key in your account `Settings` (i.e., visit `https://git.{domain}/user/settings/keys`).

## Remove

```
./destroy-gitea.sh
```

## Limitations 

The current implementation does not employ a persistent volume, therefore if the pod crashes or is restarted, all state (including accounts and repositories) will be lost.  This will be fixed in an upcoming release.