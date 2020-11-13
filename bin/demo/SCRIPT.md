# tf4k8s Demo Transcript

This collection of scripts will serve as a guided tour through tf4k8s capabilities. 

## Pre-demo preparation

We're going to launch an Ubuntu virtual machine so we can simulate what the experience might be like to go from "zero-to-hero".

### Download and install 

* [Windows](https://multipass.run/download/windows)
* [MacOS](https://multipass.run/download/macos)
* [Linux](https://snapcraft.io/multipass)

### Launch a virtual machine

```
multipass launch --name tf4k8s --cpus 4 --mem 8G --disk 30G 20.04
```

### Shell into the VM

```
multipass shell tf4k8s
```

## Introduction

Hello, my name is ... and I am a ... with ... .  

Today I want to show you a project named tf4k8s that will help you quickly and expediently configure and launch Kubernetes clusters on AWS, Google Cloud, or Microsoft Azure.  

Once you've launched a cluster you'll probably want to install some workloads, right?  

There's a number of canned modules that employ BaSH and Terraform to deploy a variety of popular open-source Helm charts and other products from the Tanzu portfolio including Tanzu Application Service for Kubernetes. 

Let's get started.

## Cloning the repo

As you can see we are at an Ubuntu Linux terminal prompt.  If you're running a different operating system, then you can download and install Multipass to launch your own Linux demo environment. 

Start by cloning the `tf4k8s` repository then hop into the `bom` directory

```
git clone https://github.com/pacphi/tf4k8s
cd tf4k8s/bom
```

We'll run the `setup-linux.sh` script to install the necessary tools and CLIs that tf4k8s needs.  The bom directory has a README file that lists all the software that is downloaded and installed.  This might take a while so go grab your favorite beverage.

```
./setup-linux.sh
```

## So you want some Kubernetes?

Now that we have all the gear we require it's time to decide which cloud we want to play in.  

Let's start with Google Cloud.  

### Authenticating

You'll need to sign-up for an account.  I've got one already.  So, let's authenticate. 

```
gcloud auth login
```

### Setting up a service account

Afterwards, I may choose to create a new project if the account I authenticated with is authorized to do so.  However, I'm going to stick with an existing project that my account is assigned to.

Next, we'll want to create a service account and assign a role. For the purposes of this demo, I'm assigning the **owner** role, but I wouldn't recommend you do that. You should really think about granting a reduced set of privileges to any service account based upon one or more roles and permissions.

```
gcloud iam service-accounts create tf4k8s-sa
gcloud projects add-iam-policy-binding {project} --member="serviceAccount:tf4k8s-sa@{project}.iam.gserviceaccount.com" --role="roles/owner"
```

### Store the service account key file somewhere

Let's fetch and store the service account key file that we'll use for subsequent operations.

```
gcloud iam service-accounts keys create tf4k8s-sa.{project}.json --iam-account=tf4k8s-sq@{project}.iam.gserviceaccount.com
mkdir -p ~/.tf4k8s/gcp
mv tf4k8s-sa.{project}.json ~/.tf4k8s/gcp
```

### Conducting our first experiment

Let's place ourselves within the `gcp` sub-tree of the `tf4k8s/experiments` directory

```
cd ../experiments/gcp
```

What do we need to do in order to provision a GKE cluster?

Let's navigate to the `cluster` sub-directory and list the contents of that directory

```
cd cluster
ll
```

I want to draw attention to the fact that all experiments are structured similarly.  You'll employ BaSH script to create and destroy resources.  Those scripts delegate to Terraform which will in turn delegate to an array of plugins.  Terraform's claim to fame is that it fully embraces the tenet of "Infrastructure as Code" in order to provision and manage any cloud, infrastructure, or service - repeatably and predictably.  It's certainly beyond the scope of this demo to delve too deeply into the inner workings of Terraform. Suffice it to say each experiment will invoke one or more modules. Each experiment is encapsulated in a file or files with a `.tf` extension.  Your job is to review the sample configuration in the file named `terraform.tfvars.sample`.  Make a copy of sample configuration into a file named `terraform.tfvars`, then update the configuration there as required.  Finally, you'll execute a BaSH script.  Of course, all these steps, and any pre-requisites, are explained in the `README.md` of each experiment. 

Let's see this in action... 

```
cat simple-cluster.tf
cat terraform.tfvars.sample
cp terraform.tfvars.sample terraform.tfvars
```

The Terraform module we employ will deploy a public cluster (all nodes will be publicly addressable) in a regional topology.  It's important that we size the the cluster appropriately to accommodate all forthcoming workloads.  So we're going to set `gke_nodes` to 8, which will provision 8 nodes per zone and 3 zones per region for a total of 24 nodes.

```
vi terraform.tfvars
./create-cluster.sh
```

Notice that Terraform reported the name and location (i.e., region) of your cluster. 

We'll want cluster admin credentials, so we'll execute a script to get and set the `kubectl` context.

```
./set-kubectl-context.sh {cluster-name} {region}

```

We're going to need them as we journey beyond just having secured Kubernetes dial-tone.


## How to deliver a platform?

If you've spent any amount of time evaluating Kubernetes you know that a cluster on its own does not buy you much.  You may be taking your first steps or perhaps you're further along on your cloud native journey to be aware of the significant engineering investments you've made or still need to make to in order to rapidly, repeatably, and securely host applications packaged and run as containers in a production environment.  But I'm getting ahead of myself here.  We've only just completed provisioning a single cluster. 

To be useful, a cluster requires a complement of other foundational capabilities like: nginx-ingress-controller, a cert manager, and external-dns (which makes Kubernetes resources discoverable via public DNS servers).  Furthermore if you intend to deploy containers you'll want to spin up a trusted cloud-native repository like Harbor.  Finally, for the developers in the audience who may be aware of the Cloud Foundry haiku - "Here is my source code, run it in the cloud for me, I don't care how" - why wouldn't you want to deliver that same awesome cf push experience on top of Kubernetes?

I'm going to run through a series of experiments that sets all this up, culminating in the deployment of Tanzu Application Service for Kubernetes. Are you ready? Buckle up.

### Step 1: Establish a cloud zone

For the purposes of this demo I want to provide public access to Harbor and to Tanzu Application Service for Kubernetes.  I have a domain that I've secured through `hover.com`, a domain registrar, known as `ironleg.me`.  I have already provisioned a cloud-zone known as `ironleg-zone` that is responsible for managing `NS` records for `ironleg.me`.  I now want to create a new domain known as `grizzly.ironleg.me` and that domain will be managed in a new cloud-zone known as `grizzly-zone`.

Let's see how this is done...

```
cd ../dns
cat managed-zone.tf
cat terraform.tfvars.sample
cp terraform.tfvars.sample terraform.tfvars
vi terraform.tfvars
./create-dns.sh
```

That was simple, huh?


### Step 2: Install cert-manager

> cert-manager runs within your Kubernetes cluster as a series of deployment resources. It utilizes `CustomResourceDefinitions` to configure `Certificate Authorities` and `request certificates`.  

We're going to employ the Jetstack Helm chart to install it.  

```
cd ../certmanager
cat certmanager.tf
cat terraform.tfvars.sample
cp terraform.tfvars.sample terraform.tfvars
vi terraform.tfvars
./create-certmanager.sh
```

Once you’ve installed cert-manager, you can verify it is deployed correctly by checking the `cert-manager` namespace for running pods

```
kubectl get pods --namespace cert-manager
```

### Step 3: Install ingress controller

> nginx-ingress is an Ingress controller for Kubernetes using NGINX as a reverse proxy and load balancer.  

We're going to use the Bitnami chart to install it.

```
cd ../../k8s/nginx-ingress
cat nginx-ingress.tf
cat terraform.tfvars.sample
cp terraform.tfvars.sample terraform.tfvars
vi terraform.tfvars
./create-nginx-ingress.sh
```

Verify it is deployed correctly by checking the `nginx-ingress` namespace for running pods.

```
kubectl get pods --namespace nginx-ingress
```

### Step 4: Install external-dns

> ExternalDNS allows you to control DNS records dynamically via Kubernetes resources in a DNS provider-agnostic way.  

We're going to use another Bitnami chart to install it.

```
cd ../../gcp/external-dns
cat external-dns.tf
cat terraform.tfvars.sample
cp terraform.tfvars.sample terraform.tfvars
vi terraform.tfvars
./create-external-dns.sh
```

Again, verify it is deployed correctly by checking the `external-dns` namespace for running pods.

```
kubectl get pods --namespace external-dns
```

### Step 5: Install Harbor

> Harbor is an open source registry that secures artifacts with policies and role-based access control, ensures images are scanned and free from vulnerabilities, and signs images as trusted. Harbor, a CNCF graduated project, delivers compliance, performance, and interoperability to help you consistently and securely manage artifacts across cloud native compute platforms like Kubernetes and Docker.

We'll employ the Harbor Helm chart to install it.

```
cd ../../k8s/harbor
cat harbor.tf
cat terraform.tfvars.sample
cp terraform.tfvars.sample terraform.tfvars
vi terraform.tfvars
./create-harbor.sh
```

Notice how Terraform handed you back a URL and admin credentials? Take note of the them.  Verify you can login to Harbor by visiting the URL in your favorite browser.  In the last step, we're going to integrate Harbor with Tanzu Application Service for Kubernetes. Harbor will be the backing repository for all container images.

### Step 6: Install Tanzu Application Service for Kubernetes

You've made it this far with me, we've only a little further to go. You're going to need an account on Tanzu Network.  Once you've registered and created an API token, you can download software via the `pivnet` CLI.  We're going to provision a multi-tenant PaaS where the intent is to industrialize the practice of continuous delivery.  One exciting benefit is that we can light up a foundation consisting of a smaller footprint of pods and containers in under 10-minutes whereas with Tanzu Application Service for VMs we'd have waited 2-3 hours and sprawled across dozens of virtual machines.

By now you've gotten used to copying and editing the configuration, right?

```
cd ../tas4k8s
cat tas4k8s.tf
cat terraform.tfvars.sample
cp terraform.tfvars.sample terraform.tfvars
vi terraform.tfvars
```

We need to author a separate `.tfvars` file to store the credentials used to generate a certificate via Let's Encrypt.

```
vi iaas.auto.tfvars
```

Let's burn the candle...

```
./create-tas4k8s.sh gcp {tanzu-network-api-token}
```

Take some time to stand up and stretch.  Come back a few moments later, and if you're lucky, you should be rewarded with a CF API endpoint and admin credentials.

And the Applications Manager interface will be available at `https://console.tas.{domain}`.


## In conclusion

I want to thank you for spending time with me today to learn a little about tfk48s.  I hope you find it useful for demonstrations and self-paced evaluations.  Do take some time to familiarize yourself with the other experiments, there's quite a bit more here.  And you're not just limited to Google Cloud.  You could rinse-and-repeat the above on Microsoft Azure (AKS), AWS (EKS) or with Tanzu Kubernetes Grid (TKGm). 

If you're keen on GitOps and wondering how to take some of what was shown here a bit further with Concourse, then you might want to take a look at https://github.com/pacphi/tf4k8s-pipelines. 
