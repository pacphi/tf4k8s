# Installing Tanzu Build service on Kubernetes

This experiment aims to fast-track [installation](https://docs.pivotal.io/build-service/1-0/installing.html) of TBS using a collection of scripts.

Starts with the assumption that you have already provisioned a cluster.

## Install Tools

```
./install-{os}.sh {pivnet-api-token}
```
> Replace `{os}` with either: `macos` or `linux` and `{pivnet-api-token}` with a valid VMWare Tanzu Network [API Token](https://network.pivotal.io/users/dashboard/edit-profile)

## Download the bits

```
./download-tbs.sh {pivnet-api-token}
./download-tbs-descriptor.sh {pivnet-api-token}
```

## Authenticate Docker with Harbor

Login to the image registry where you want to store the images

```
./auth-registry.sh {image-registry} {image-registry-username} {image-registry-password}
```
> Replace the curly-braced parameters above with your Harbor domain and administrative credentials

## Relocate the images to Harbor

Yes, you could specify an alternate image registry provider

```
./relocate-images.sh {tanzu-network-username} {tanzu-network-password} {image-repository}
```

Sit back and enjoy a beverage... this may take a while.

## Install TBS integrated with Harbor on a Kubernetes cluster

```
./install-tbs-integrated-with-harbor.sh {harbor-domain} {harbor-project} {harbor-username} {harbor-password}
```
> Replace the curly-braced parameters above with your Harbor domain, project and administrative credentials

Take another break.

## Verify your installation

```
kp clusterbuilder list
```
