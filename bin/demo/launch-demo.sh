#!/usr/bin/env bash

# tf4k8s Demo Script
# @author Chris Phillipson
# @version 1.1

while test $# -gt 0
do
  case "$1" in

    --dry-run | -dr)
    DRY_RUN=true
    declare -i TYPE_SPEED_MULTIPLIER=10
    ;;

    --run | -r)
    DRY_RUN=false
    declare -i TYPE_SPEED_MULTIPLIER=1
    ;;

  esac
  shift
done

function r() {
  if [ "$DRY_RUN" = true ]; then
    echo "$@"
  else
    pe "$@"
  fi
}

function rc() {
  if [ "$DRY_RUN" = true ]; then
    echo ""
  else
    echo "$@"
  fi
}

# Configuration options
source demo-config.sh

declare -i TOTAL_ZONAL_NODES=$GKE_NODES*3
GCP_SA_KEY_FILE_PATH="~/.tf4k8s/gcp/$GCP_SERVICE_ACCOUNT.$GCP_PROJECT.json"

CLUSTER_TFVARS=$(cat <<EOF
gcp_project = "$GCP_PROJECT"
gcp_region = "$GCP_REGION"
gke_name = "$K8S_ENV"
gke_nodes = $GKE_NODES
gke_preemptible = false
gke_node_type = "$GKE_NODE_TYPE"
gcp_service_account_credentials = "$GCP_SA_KEY_FILE_PATH"
EOF
)

DNS_TFVARS=$(cat <<EOF
project = "$GCP_PROJECT"
root_zone_name = "$BASE_NAME-zone"
environment_name = "$SUB_NAME"
dns_prefix = "$SUB_NAME"
gcp_service_account_credentials = "$GCP_SA_KEY_FILE_PATH"
EOF
)

CERTMGR_TFVARS=$(cat <<EOF
project = "$GCP_PROJECT"
domain = "$SUB_DOMAIN"
acme_email = "$EMAIL_ADDRESS"
dns_zone_name = "$SUB_NAME-zone"
gcp_service_account_credentials = "$GCP_SA_KEY_FILE_PATH"
EOF
)

EXTERNAL_DNS_TFVARS=$(cat <<EOF
domain_filter = "$SUB_DOMAIN"
gcp_project = "$GCP_PROJECT"
gcp_service_account_credentials = "$GCP_SA_KEY_FILE_PATH"
EOF
)

HARBOR_TFVARS=$(cat <<EOF
domain = "$SUB_DOMAIN"
ingress = "nginx"
EOF
)

TAS4K8S_TFVARS=$(cat <<EOF
base_domain = "$SUB_DOMAIN"
registry_domain = "harbor.$SUB_DOMAIN"
repository_prefix = "harbor.$SUB_DOMAIN/library"
registry_username = "admin"
pivnet_username = "$EMAIL_ADDRESS"
pivnet_password = "$TANZU_NETWORK_ACCOUNT_PASSWORD"
EOF
)

ACME_TFVARS=$(cat <<EOF
email = "$EMAIL_ADDRESS"
domain = "$SUB_DOMAIN"
project = "$GCP_PROJECT"
EOF
)

###

# DO NOT CHANGE ANYTHING BELOW UNLESS YOU KNOW WHAT YOU'RE DOING!

# Include the demo-magic.sh utility script (@see https://github.com/paxtonhare/demo-magic)
. ./demo-magic.sh -n
declare -i TYPE_SPEED=100*$TYPE_SPEED_MULTIPLIER


# Utility function for a prompt; in order to provide helpful explanation at each step
function prompt() {
  echo; printf "${GREEN}> $*${COLOR_RESET}"
  echo; echo;
}

# Get ourselves into a safe place
cd /tmp
# Clean-up any prior clone
rm -Rf /tmp/tf4k8s

# Hide the evidence
clear

# Begin demo
wait

prompt Introduction
p "Greetings, $NAME here, I'm a $TITLE within $ORG." 
p "I'd like to introduce you to a project named tf4k8s that makes it simple to provision Kubernetes clusters on: AWS, Google Cloud, or Microsoft Azure with BaSH and Terraform."
p "Beyond that there's a number of canned modules and experiments that deploy a variety of popular open-source Helm charts."
p "Moreover, it simplifies installing products from the Tanzu portfolio including Tanzu Application Service for Kubernetes."
p "Let's get started."
wait

prompt Cloning the repo
p "Start by cloning the tf4k8s repository then hop into the bom directory."
r git clone https://github.com/pacphi/tf4k8s
r cd tf4k8s/bom

p "Execute the setup script appropriate for your operating system in order to download and install the necessary libraries and CLIs that tf4k8s needs."  
p "The bom directory has a README file that lists all the software that is downloaded and installed."
p "This takes a few minutes, so in the interest of time, I'll skip this step since I have all the required software installed."
wait

prompt So you want some Kubernetes?
p "Now it's time to decide which cloud we want to set up a playground in."
p "I've no bias, so let's pick Google Cloud ;)."
wait

prompt Sign-up and authentication
p "You'll need to sign-up for an account if you don't have one.  I've got one already.  But I need to authenticate."
p "My employer requires two-factor authentication, so I'll need to supply a password and PIN."
wait
r gcloud auth login
wait

prompt Setting up a service account
p "I may choose to create a new project if the account I authenticated with is authorized to do so."
p "However, I'm going to stick with an existing project that my account is assigned to."
p "Next, we'll want to create a service account and assign a role. In the context of this demo, "
p "I'm assigning the [ owner ] role, but I wouldn't recommend you do that."
p "You should really think about granting a reduced set of privileges to any service account based upon one or more roles and/or permissions."
wait
r gcloud iam service-accounts create $GCP_SERVICE_ACCOUNT
r gcloud projects add-iam-policy-binding $GCP_PROJECT --member="serviceAccount:$GCP_SERVICE_ACCOUNT@$GCP_PROJECT.iam.gserviceaccount.com" --role="roles/owner"
wait

prompt Store the service account key file somewhere
p "Let's fetch and store the service account key file that we'll use for subsequent operations."
wait
r gcloud iam service-accounts keys create $GCP_SERVICE_ACCOUNT.$GCP_PROJECT.json --iam-account=$GCP_SERVICE_ACCOUNT@$GCP_PROJECT.iam.gserviceaccount.com
r mkdir -p ~/.tf4k8s/gcp
r mv $GCP_SERVICE_ACCOUNT.$GCP_PROJECT.json ~/.tf4k8s/gcp
wait

prompt The first experiment - provisioning a GKE cluster
p "Let's place ourselves within the [ gcp ] sub-tree of the [ tf4k8s/experiments ] directory."
r cd ../experiments/gcp
wait
p "Let's take a look at the contents of this directory."
r ls -la
wait
p "Where should we go in order to provision a GKE cluster?"
p "The cluster sub-directory of course."
r cd cluster
r ls -la
wait
p "I want to draw attention to the fact that all experiments are structured similarly."
p "You'll employ BaSH scripts to create and destroy resources."
p "Those scripts delegate to Terraform which will in turn delegate to an array of providers."
p "Terraform's claim to fame is that it fully embraces the tenet of infrastructure-as-code in order to"
p "provision and manage any cloud, infrastructure, or service - repeatably and predictably."
p "It's certainly beyond the scope of this demo to delve too deeply into the inner workings of Terraform."
p "Suffice it to say each experiment will invoke one or more modules. Most modules leverage the Terraform Helm provider."
p "Each experiment is encapsulated in a file or files with a [ .tf ] extension."
p "Your job is to review the sample configuration in the file named [ terraform.tfvars.sample ]."
p "Make a copy of sample configuration into a file named [ terraform.tfvars ], then update the configuration there as required."
p "Finally, you'll execute a BaSH script."
p "Of course, all these steps, and any prerequisites, are explained in the README of each experiment."
p "So, let's see what we need to do."
wait
r cat simple-cluster.tf
r cat terraform.tfvars.sample
r cp terraform.tfvars.sample terraform.tfvars
p "The Terraform module we employ will deploy a public cluster (all nodes will be publicly addressable) in a regional topology."
p "It's important that we size the cluster appropriately to accommodate all forthcoming workloads."
p "So we're going to set [ gke_nodes ] to [ $GKE_NODES ], which will provision $GKE_NODES nodes per zone and 3 zones per region for a total of $TOTAL_ZONAL_NODES nodes."
p "And there's a few other settings we'll tweak like the cluster name, node type, and service account key file location."
rc "$CLUSTER_TFVARS" > terraform.tfvars
r cat terraform.tfvars
wait
p "Ready, set, go..."
r "./create-cluster.sh"
wait
p "Note Terraform returns the name and location (i.e., region) of your cluster and hands you a kubeconfig."
p "Let's set the KUBECONFIG environment variable."
r export KUBECONFIG=$(terraform output path_to_kubeconfig)
wait
p "We're going to need it as we journey beyond just having secured Kubernetes dial-tone."
p "Before we wrap this first experiment, let's check in on the nodes and pods in our cluster."
wait
r kubectl get nodes -A -o wide
wait
r kubectl get pods -A -o wide
wait

prompt How to deliver a platform?
p "If you've spent any amount of time evaluating Kubernetes you know that a cluster on its own does not buy you much."
p "You may be taking your first steps or perhaps you're far enough along on your cloud native journey to become aware"
p "of the significant engineering investments you've made (or still need to make) to in order to rapidly, repeatably,"
p "and securely host applications packaged and run as containers in a production environment."
p "But I'm getting ahead of myself here.  We've only just completed provisioning a single cluster."
p "To be useful, a cluster requires a complement of other foundational capabilities like: "
p "an ingress controller, a certificate manager, and something to make Kubernetes resources discoverable via public DNS servers."
p "Furthermore if you intend to deploy containers, you'll want to spin up a private container image registry."
p "Finally, for the developers in the audience who may be aware of the Cloud Foundry haiku - 'Here is my source code,"
p "run it in the cloud for me, I don't care how.' - why wouldn't you want to deliver that same awesome 'cf push' experience on top of Kubernetes?"
p "I'm going to run through a series of experiments that sets all this up, culminating in the deployment of Tanzu Application Service for Kubernetes."
p "Are you ready? Buckle up."
wait

prompt Step 1: Establish a cloud zone
p "For the purposes of this demo I want to provide public access to Harbor and to Tanzu Application Service for Kubernetes."
p "I have a domain that I've secured through [ $REGISTRAR ], a domain registrar, known as [ $BASE_DOMAIN ].  I have already"
p "provisioned a cloud zone known as [ $BASE_NAME-zone ] that is responsible for managing [ NS ] records for [ $BASE_DOMAIN ]."
p "I now want to create a new domain known as [ $SUB_DOMAIN ] and that domain will be managed in a new cloud-zone known as [ $SUB_NAME-zone ]."
p "Let's see how this is done."
wait
r cd ../dns
r cat managed-zone.tf
r cat terraform.tfvars.sample
r cp terraform.tfvars.sample terraform.tfvars
p "We're going to edit the path to the service account key file, the GCP project id, the root zone, DNS prefix and environment."
wait
rc "$DNS_TFVARS" > terraform.tfvars
r cat terraform.tfvars
wait
r ./create-zone.sh
wait
p "That was pretty straight-forward, huh?"
wait

prompt Step 2: Install cert-manager
p "[ cert-manager ] is a native Kubernetes certificate management controller. It can help with issuing certificates from a variety of sources,"
p "such as Let’s Encrypt, HashiCorp Vault, Venafi, a simple signing key pair, or self signed."
p "It will ensure certificates are valid and up to date, and attempt to renew certificates at a configured time before expiry."
p "Terraform will delegate to a Jetstack Helm chart to install it."
wait
r cd ../certmanager
r cat certmanager.tf
r cat terraform.tfvars.sample
r cp terraform.tfvars.sample terraform.tfvars
p "We're going to edit the path to service account key file, the domain, the GCP project id, email address, cloud zone, and the path to kubeconfig."
wait
rc "$CERTMGR_TFVARS" > terraform.tfvars
rc "kubeconfig_path = \"$KUBECONFIG\"" >> terraform.tfvars
r cat terraform.tfvars
wait
r ./create-certmanager.sh
p "Let's verify it is deployed correctly by checking the [ cert-manager ] namespace for running pods."
r kubectl get pods --namespace cert-manager
wait

prompt Step 3: Install ingress controller
p "[ nginx-ingress ] is an Ingress controller for Kubernetes using NGINX as a reverse proxy and load balancer."
p "Terraform will delegate to a Bitnami Helm chart to install it."
wait
r cd ../../k8s/nginx-ingress
r cat nginx-ingress.tf
r cat terraform.tfvars.sample
r cp terraform.tfvars.sample terraform.tfvars
p "Not much to edit save for the the path to kubeconfig."
wait
rc "$INGRESS_TFVARS" > terraform.tfvars
rc "kubeconfig_path = \"$KUBECONFIG\"" >> terraform.tfvars
r cat terraform.tfvars
wait
r ./create-nginx-ingress.sh
p "Let's verify it is deployed correctly by checking the [ nginx-ingress ] namespace for running pods."
r kubectl get pods --namespace nginx-ingress
wait

prompt Step 4: Install external-dns
p "[ external-dns ] allows you to control DNS records dynamically via Kubernetes resources in a provider-agnostic way."
p "Terraform will again delegate to a Bitnami Helm chart to install it."
wait
r cd ../../gcp/external-dns
r cat external-dns.tf
r cat terraform.tfvars.sample
r cp terraform.tfvars.sample terraform.tfvars
p "We're going to edit the path to kubeconfig, the GCP project id, and the domain."
wait
rc "$EXTERNAL_DNS_TFVARS" > terraform.tfvars
rc "kubeconfig_path = \"$KUBECONFIG\"" >> terraform.tfvars
r cat terraform.tfvars
wait
r ./create-external-dns.sh
wait
p "Let's verify it is deployed correctly by checking the [ external-dns ] namespace for running pods."
r kubectl get pods --namespace external-dns
wait

prompt Step 5: Install a private container image registry
p "[ Harbor ] is an open source registry that secures artifacts with policies and role-based access control,"
p "ensures images are scanned and free from vulnerabilities, and signs images as trusted."
p "Harbor, a CNCF graduated project, delivers compliance, performance, and interoperability to help you"
p "consistently and securely manage artifacts across cloud native compute platforms like Kubernetes."
p "Terraform will delegate to the Harbor Helm chart to install it."
wait
r cd ../../k8s/harbor
r cat harbor.tf
r cat terraform.tfvars.sample
r cp terraform.tfvars.sample terraform.tfvars
p "All we need to edit is the domain and the path to kubeconfig."
wait
rc "$HARBOR_TFVARS" > terraform.tfvars
rc "kubeconfig_path = \"$KUBECONFIG\"" >> terraform.tfvars
r cat terraform.tfvars
wait
r ./create-harbor.sh
wait
p "Notice how Terraform handed you back an endpoint and admin credentials?"
p "Take note of the them.  Verify you can login to Harbor by visiting the endpoint in your favorite browser."
p "In the last step, we're going to integrate Harbor with Tanzu Application Service for Kubernetes."
p "Harbor will be the backing repository for all container images."
p "Let's set a few environment variables for convenience."
r export HARBOR_ENDPOINT=$(terraform output harbor_endpoint)
r export HARBOR_ADMIN_PASSWORD=$(terraform output harbor_admin_password)
wait

prompt Step 6: Install Tanzu Application Service for Kubernetes
p "You've made it this far with me, we've only a little further to go. You're going to need an account on Tanzu Network."
p "Once you've registered and created an API token, you can download software via the [ pivnet ] CLI."
p "We're going to provision a multi-tenant PaaS where the intent is to industrialize the practice of continuous delivery."
p "One exciting benefit is that we can light up a foundation consisting of a smaller footprint of pods and containers in"
p "less than 10 minutes whereas with Tanzu Application Service for VMs we'd have waited 2-3 hours and sprawled across"
p "dozens of virtual machines."
p "Terraform is going to delegate to the Carvel (formerly known as k14s) provider to install TAS."
p "You know the drill. We're going to make a copy of sample configuration then edit the copy."
p "This time around we'll have to add one more .tfvars file to store the credentials used to generate certificates via Let's Encrypt."
wait
r cd ../tas4k8s
r cat tas4k8s.tf
r cat terraform.tfvars.sample
rc "$TAS4K8S_TFVARS" > terraform.tfvars
rc "registry_password = \"$HARBOR_ADMIN_PASSWORD\"" >> terraform.tfvars
rc "kubeconfig_path = \"$KUBECONFIG\"" >> terraform.tfvars
rc "$ACME_TFVARS" > iaas.auto.tfvars
p "Let's light this candle!"
wait
p "In the meanwhile, lets take some time to stand up and stretch.  Come back a few moments later, and if we're lucky,"
p "we should be rewarded with a CF API endpoint and admin credentials."
wait
r ./create-tas4k8s.sh gcp $TANZU_NETWORK_API_TOKEN
wait
p "Congratulations! You've just up-leveled your Kubernetes game and built a foundation your developers will love."
p "Let's test it out."
r cf api $(terraform output tas_api_endpoint)
r cf auth $(terraform output tas_admin_username) $(terraform output tas_admin_password)
p "Yup! We can login with administrator credentials and get to work creating organizations, setting quotas, creating spaces and of course onboarding new users."
wait

prompt In conclusion
p "I want to thank you for spending time with me to learn a little about tfk48s."
p "I hope you'll find it useful for demonstrations and self-paced evaluations."
p "Do take some time to explore and familiarize yourself with the other experiments, there's quite a bit more here."
p "It's worth noting you're not just limited to targeting Google Kubernetes Engine as we did here."
p "You could absolutely rinse-and-repeat what I've shown you on Microsoft Azure (AKS), AWS (EKS) or Tanzu Kubernetes Grid (TKGm)." 
p "If you're keen on GitOps and wondering how to take some of what was shown here a bit further with Concourse, then you might want to take a look at"
p "https://github.com/pacphi/tf4k8s-pipelines."
p "--THE END--"