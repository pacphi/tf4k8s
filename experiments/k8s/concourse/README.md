# Terraform for creating a Concourse CI/CD instance

Built on the simple mechanics of resources, tasks, and jobs, Concourse presents a general approach to automation that makes it great for CI/CD.

This sample makes use of this [chart](https://github.com/concourse/concourse-chart).

Starts with the assumption that you have already provisioned a cluster.

## Edit `terraform.tfvars`

Amend the values for

* `domain`
* `ingress`
* `kubeconfig_path`

## Create

```
./create-concourse.sh
```

## Use

Login to the Concourse UI.  Visit `https://{concourse_domain}` in your favorite browser.

> If you forgot your credentials, you can use `terraform output` in the root folder of this experiment.

However, your primary interaction will be through the [fly](https://concourse-ci.org/fly.html) CLI.  It's preferable to download, install, and keep in-sync the CLI from the instance you'll interact with.

There's an abundance of documentation and tutorials online.  Here's a sampling:

* Pluralsight's [Getting Started with Concourse](https://www.pluralsight.com/courses/concourse-getting-started)
* Stark and Wayne's 
  * [What is Concourse?](https://starkandwayne.com/blog/video-001-what-is-concourse-and-getting-started/)
  * [Basic Pipeline](https://concoursetutorial.com/basics/basic-pipeline/)
* Tammy Torres' [Concourse in 4 Steps](https://medium.com/@TammyTorres/what-is-concourse-learn-the-basics-in-4-steps-4b4b8b2f4a2d)


## Destroy

To tear it down

```
./destroy-concourse.sh
```
