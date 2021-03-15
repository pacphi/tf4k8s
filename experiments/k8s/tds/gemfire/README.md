# Installing Tanzu Gemfire for Kubernetes

This experiment aims to fast-track [installation](https://tgf.docs.pivotal.io/tgf/1-0/install.html) of Tanzu Gemfire using a collection of scripts.

Prerequisites:

* Starts with the assumption that you have already provisioned a cluster.
* Also see [Prerequisites and Supported Platforms](https://tgf.docs.pivotal.io/tgf/1-0/supported-configurations.html)

## Download the bits

```
./download-tanzu-gemfire.sh {tanzu-network-api-token} {tanzu-network-username} {tanzu-network-password}
```
> Yes, you need to supply both the token and your credentials for the Tanzu Network.  Chart is fetched by token and the images are pulled using your credentials.


## Install Tanzu Gemfire integrated with Harbor on a Kubernetes cluster

```
./install-tanzu-gemfire-integrated-with-harbor.sh {harbor-domain} tanzu {harbor-username} {harbor-password}
```
> Replace the curly-braced parameters above with your Harbor domain, project and administrator username. The project named `tanzu` should already exist within Harbor.

## Using Tanzu Gemfire

* [Create and delete](https://tgf.docs.pivotal.io/tgf/1-0/create-and-delete.html)
  * Note: when creating an instance, remember to replace `image` in `spec` with the one you relocated to your private container registry's repository  
* [Update](https://tgf.docs.pivotal.io/tgf/1-0/update.html)
* [Work with](https://tgf.docs.pivotal.io/tgf/1-0/work-with-cluster.html)
* [gfsh CLI Command Index](https://gemfire.docs.pivotal.io/910/gemfire/tools_modules/gfsh/gfsh_command_index.html)

## Uninstall Tanzu Gemfire

```
./uninstall-tanzu-gemfire.sh
```