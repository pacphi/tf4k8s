# Terraform for installing JFrog Container Registry

Uses [kubernetes](https://www.terraform.io/docs/providers/kubernetes/index.html), [helm](https://www.terraform.io/docs/providers/helm/index.html) and [k14s](https://github.com/k14s/terraform-provider-k14s) Terraform providers to install [JFrog Container Registry](https://hub.helm.sh/charts/jfrog/artifactory-jcr).

JFrog Container Registry is a free Artifactory edition with Docker and Helm repositories support.

Starts with the assumption that you have already provisioned a cluster.

## Edit `terraform.tfvars`

Amend the values for

* `domain`
* `ingress`
* `kubeconfig_path`

## Install

```
./create-jcr.sh
```

### First-time configuration

Obtain the value of `jcr_endpoint` from your Terraform output.

Visit the site in your favorite browser and authenticate with

* username: `admin`
* password: `password`

Once authenticated, an onboarding wizard will start guiding you through the steps to setup your instance of JFrog Container Registry.

* Scroll through the text of the `EULA Confirmation`, then click the checkbox next to the `I have read and agree to the terms and conditions stated in the EULA` to confirm you have read it, then click the `Next` button.
* Click the `Next` button without entering an email on the `Subscribe for Newsletter` step.
* Enter a password in the `New Password` and `Confirm Password` fields of the `Reset Admin Password` step, then click the `Next` button.
* Enter a url in the `Select Base URL` field of the `Set base URL` step, then click the `Next` button.  (The value you enter here should be the same as the `jcr_endpoint` value from your Terraform output).
* Click the `Next` button accepting the defaults in the `Configure Default Proxy` step.  (We're choosing not to configure or secure a proxy).
* Chick the checkboxes underneath the `Docker` and `Helm` icons underneath the `Freemium Offering` heading in the `Create Repositories` step, then click the `Next` button.
* Click the `Finish` button to complete the one-time setup process.

> The steps above are illustrated in the JFrog Container Registry `Getting Started` documentation [here](https://www.jfrog.com/confluence/display/JFROG/Get+Started%3A+JFrog+Container+Registry).


## Use

So, how do you push a container image into the Docker repository hosted in your instance of JFrog Container Registry?

Here's a sample work flow

```
docker login https://jcr.daf.ironleg.me
docker pull busybox
docker tag busybox:latest jcr.daf.ironleg.me/docker/busybox:1.0
docker push jcr.daf.ironleg.me/docker/busybox:1.0
```

The following documentation provides more detailed information about how to work with a

* [Docker Registry](https://www.jfrog.com/confluence/display/JCR6X/Getting+Started+with+JFrog+Container+Registry+as+a+Docker+Registry)
* [Helm Registry](https://www.jfrog.com/confluence/display/JCR6X/Helm+Registry)


## Remove

```
./destroy-jcr.sh
```
