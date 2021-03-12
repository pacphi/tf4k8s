# Installing Spring Cloud Gateway on Kubernetes

This experiment aims to fast-track [installation](https://docs.pivotal.io/scg-k8s/1-0/installation.html) of SCG using a collection of scripts.

Starts with the assumption that you have already provisioned a cluster.

## Download the bits

```
./download-scg.sh {tanzu-network-api-token}
```

## Authenticate Docker with Harbor

Login to the image registry where you want to store the images

```
./auth-registry.sh {image-registry} {image-registry-username} {image-registry-password}
```
> Replace the curly-braced parameters above with your Harbor domain and administrative credentials


## Install SCG integrated with Harbor on a Kubernetes cluster

```
./install-scg-integrated-with-harbor.sh {harbor-domain} tanzu
```
> Replace the curly-braced parameters above with your Harbor domain, project and administrator username. The project named `tanzu` should already exist within Harbor.

## Using SCG

Consult the [developer guide](https://docs.pivotal.io/scg-k8s/1-0/getting-started.html).

## Uninstall SCG

```
./uninstall-scg.sh
```