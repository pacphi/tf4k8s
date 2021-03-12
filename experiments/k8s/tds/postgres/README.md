# Installing Tanzu SQL with Postgres for Kubernetes

This experiment aims to fast-track [installation](https://postgres-kubernetes.docs.pivotal.io/1-1/installing.html) of Tanzu SQL with Postgres using a collection of scripts.

Starts with the assumption that you have already provisioned a cluster.

## Download the bits

```
./download-tanzu-postgres.sh {tanzu-network-api-token}
```

## Authenticate Docker with Harbor

Login to the image registry where you want to store the images

```
./auth-registry.sh {image-registry} {image-registry-username} {image-registry-password}
```
> Replace the curly-braced parameters above with your Harbor domain and administrative credentials


## Install Tanzu SQL with Postgres integrated with Harbor on a Kubernetes cluster

```
./install-tanzu-postgres-integrated-with-harbor.sh {harbor-domain} tanzu {harbor-username} {harbor-password}
```
> Replace the curly-braced parameters above with your Harbor domain, project and administrator username. The project named `tanzu` should already exist within Harbor.

## Using Tanzu SQL with Postgres

Consult the [developer guide](https://postgres-kubernetes.docs.pivotal.io/1-1/deploy-operator.html#instance_configure).

## Uninstall Tanzu SQL with Postgres

```
./uninstall-tanzu-postgres.sh
```