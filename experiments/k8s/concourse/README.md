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

## Destroy

To tear it down

```
./destroy-concourse.sh
```
