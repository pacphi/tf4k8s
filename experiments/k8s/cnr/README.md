# Installing Tanzu Cloud Native Runtimes on Kubernetes

This experiment aims to fast-track [installation](https://docs.vmware.com/en/Cloud-Native-Runtimes-for-VMware-Tanzu/1.0/tanzu-cloud-native-runtimes-1-0/GUID-install.html) of CNR using a collection of scripts.

Starts with the assumption that you have already provisioned a cluster.


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

> Before you run the command above you'll want to login to Harbor with admin credentials and manually create a new Project named `tanzu`.  Then make sure the value you set for `{image-repository}` is set to `{image-registry}/tanzu/cloud-native-runtimes`.

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


## Install Cloud Native Runtimes on a Kubernetes cluster

Target a workload cluster (preferably one where Contour is not already installed).

Consult these [install instructions](https://docs.vmware.com/en/Cloud-Native-Runtimes-for-VMware-Tanzu/1.0/tanzu-cloud-native-runtimes-1-0/GUID-install.html#install-cloud-native-runtimes-6) for any adaptations before executing the script below.


```
./tmp/cloud-native-runtimes/install.sh
```

Take another break.

Once the above script has completed, you may want to [update the domain configuration](https://docs.vmware.com/en/Cloud-Native-Runtimes-for-VMware-Tanzu/1.0/tanzu-cloud-native-runtimes-1-0/GUID-install.html#set-up-external-dns-13) for KNative serving.


## Verify your installation

* [Prepare to create a service](https://docs.vmware.com/en/Cloud-Native-Runtimes-for-VMware-Tanzu/1.0/tanzu-cloud-native-runtimes-1-0/GUID-service-prep.html)
* [Verify KNative Serving](https://docs.vmware.com/en/Cloud-Native-Runtimes-for-VMware-Tanzu/1.0/tanzu-cloud-native-runtimes-1-0/GUID-verifying-serving.html)
* [Verify KNative Eventing](https://docs.vmware.com/en/Cloud-Native-Runtimes-for-VMware-Tanzu/1.0/tanzu-cloud-native-runtimes-1-0/GUID-verifying-eventing.html)


## Uninstall CNR

```
./uninstall-cnr.sh
```