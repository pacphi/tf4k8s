# Installing Tanzu Configuration Service on Kubernetes

This experiment aims to fast-track [installation](https://docs.pivotal.io/tcs-k8s/0-1/installation.html) of TCS using a collection of scripts.

Starts with the assumption that you have already provisioned a cluster.

## Download the bits

```
./download-tcs.sh {tanzu-network-api-token}
```

## Authenticate Docker with Harbor

Login to the image registry where you want to store the images

```
./auth-registry.sh {image-registry} {image-registry-username} {image-registry-password}
```
> Replace the curly-braced parameters above with your Harbor domain and administrative credentials


## Install TCS integrated with Harbor on a Kubernetes cluster

```
./install-tcs-integrated-with-harbor.sh {harbor-domain} tanzu {harbor-username}
```
> Replace the curly-braced parameters above with your Harbor domain, project and administrator username. The project named `tanzu` should already exist within Harbor.  You'll be prompted to enter the password too.

## Using TCS

Consult the [developer guide](https://docs.pivotal.io/tcs-k8s/0-1/getting-started.html).

## Uninstall TCS

```
./uninstall-tcs.sh
```