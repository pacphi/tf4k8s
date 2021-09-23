# Installing Tanzu Build service on Kubernetes

This experiment aims to fast-track [installation](https://docs.pivotal.io/build-service/1-2/installing.html) of TBS using a collection of scripts.

Starts with the assumption that you have already provisioned a cluster.

## Install tools

```
./install-tools-linux.sh {tanzu-network-api-token}
```
> Replace `{tanzu-network-api-token}` with a valid VMWare Tanzu Network [API Token](https://network.pivotal.io/users/dashboard/edit-profile)

## Download the descriptors

```
./download-tbs-descriptors.sh {tanzu-network-api-token}
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

> Before you run the command above you'll want to login to Harbor with admin credentials and manually create a new Project named `tanzu`.  Then make sure the value you set for `{image-repository}` is set to `{image-registry}/tanzu/build-service`.

To automate the process of creating the new project, you could download, install and alias the [unofficial command line for Harbor](https://github.com/hinyinlam/cli-for-harbor)

```
mkdir $HOME/.harbor
wget https://github.com/hinyinlam-pivotal/cli-for-harbor/releases/download/v0.5/harbor-cli-0.0.1-SNAPSHOT.jar
mv harbor-cli-0.0.1-SNAPSHOT.jar $HOME/.harbor
alias harbor="java -jar $HOME/.harbor/harbor-cli-0.0.1-SNAPSHOT.jar"
harbor login --username {harbor-username} --password '{harbor-password}' --api {harbor-hostname}
cat > hp.json <<EOF
{ "projectName": "tanzu", "public": false }
EOF
harbor project create --project hp.json
harbor project list --name tanzu
```
> Note you could run into this [issue](https://github.com/hinyinlam/cli-for-harbor/issues/2).  It typically happens when you're on a host where the root CA is not available.



Sit back and enjoy a beverage... this may take a while.

## Install TBS integrated with Harbor on a Kubernetes cluster

```
./install-tbs-integrated-with-harbor.sh {harbor-domain} tanzu {harbor-username} {harbor-password} {tanzu-network-username} {tanzu-network-password} {registry-ca-cert-path}
```
> Replace the curly-braced parameters above with your Harbor domain, project and administrative credentials, and Tanzu Network credentials.  The harbor-ca-cert is optional but needed if you have a self signed cert on your registry.

Take another break.

## Verify your installation

```
kp clusterbuilder list
kp clusterstack list
```

## Uninstall TBS

```
./uninstall-tbs.sh
```