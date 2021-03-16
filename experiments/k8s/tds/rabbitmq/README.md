# Installing Tanzu RabbitMQ for Kubernetes

This experiment aims to fast-track [installation](https://www.rabbitmq.com/kubernetes/operator/operator-overview.html) of Tanzu RabbitMQ using a collection of scripts.

Prerequisites:

* Starts with the assumption that you have already provisioned a cluster.


## Download the bits

```
./download-tanzu-rabbitmq.sh {tanzu-network-api-token}
```

## Install Tanzu RabbitMQ integrated with Harbor on a Kubernetes cluster

```
./install-tanzu-rabbitmq-integrated-with-harbor.sh {harbor-domain} tanzu {harbor-username} {harbor-password}
```
> Replace the curly-braced parameters above with your Harbor domain, project and administrator username. The project named `tanzu` should already exist within Harbor.

## Using Tanzu RabbitMQ

* [Quickstart](https://www.rabbitmq.com/kubernetes/operator/quickstart-operator.html)
  * Skip the section on installing the OSS operator (because we already installed the Tanzu version).  Head straight for Hello RabbitMQ!
* Using the [RabbitMQ Cluster Operator Plugin for kubectl](https://www.rabbitmq.com/kubernetes/operator/kubectl-plugin.html)
* [Hello World Example](https://github.com/rabbitmq/cluster-operator/tree/main/docs/examples/hello-world)
* [RabbitMQ Production Ready Example](https://github.com/rabbitmq/cluster-operator/tree/main/docs/examples/production-ready)

## Uninstall Tanzu RabbitMQ

```
./uninstall-tanzu-rabbitmq.sh
```
