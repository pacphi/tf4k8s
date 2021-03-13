# Installing Tanzu SQL with MySQL for Kubernetes

This experiment aims to fast-track [installation](https://docs.pivotal.io/tanzu-mysql-kubernetes/0-2/install-operator.html) of Tanzu SQL with MySQL using a collection of scripts.

Starts with the assumption that you have already provisioned a cluster.

## Download the bits

```
./download-tanzu-mysql.sh {tanzu-network-api-token}
```

## Install Tanzu SQL with MySQL integrated with Harbor on a Kubernetes cluster

```
./install-tanzu-mysql-integrated-with-harbor.sh {harbor-domain} tanzu {harbor-username} {harbor-password}
```
> Replace the curly-braced parameters above with your Harbor domain, project and administrator username. The project named `tanzu` should already exist within Harbor.

## Using Tanzu SQL with MySQL

Consult the [developer guide](https://docs.pivotal.io/tanzu-mysql-kubernetes/0-2/create-delete-mysql.html).

## Uninstall Tanzu SQL with MySQL

```
./uninstall-tanzu-mysql.sh
```