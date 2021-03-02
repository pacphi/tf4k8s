#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y build-essential gnupg libnss3-tools zlibc zlib1g-dev ruby ruby-dev openssl libxslt1-dev libxml2-dev libssl-dev libreadline7 libreadline-dev libyaml-dev libsqlite3-dev python3 sqlite3
sudo apt-get install -y pv snapd unzip graphviz wget

sudo snap install snap-store

sudo snap install google-cloud-sdk --classic
sudo snap install code --classic

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
unzip awscliv2.zip && \
sudo ./aws/install

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install Homebrew; @see https://brew.sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install minimal complement of tools
brew install aws-iam-authenticator aliyun-cli doctl git libressl mkcert nss openssl terraform terraform-docs tflint httpie kind kubernetes-cli kubeseal helm helmfile krew octant

brew tap vmware-tanzu/carvel
brew install ytt kbld kapp imgpkg kwt vendir
brew install derailed/k9s/k9s

brew install jpoon/homebrew-oci-cli/oci-cli

brew install cloudfoundry/tap/bosh-cli

brew install cloudfoundry/tap/cf-cli@7

brew tap argoproj/tap
brew install argocd
brew install argoproj/tap/kubectl-argo-rollouts

brew tap tektoncd/tools
brew install tektoncd/tools/tektoncd-cli

# Install Terraform k14s provider; @see https://github.com/k14s/terraform-provider-k14s
TF_K14S_PLUGIN_VERSION=0.6.0 && \
mkdir -p ~/.terraform.d/plugins/registry.terraform.io/hashicorp/k14s/$TF_K14S_PLUGIN_VERSION && \
curl -LO "https://github.com/k14s/terraform-provider-k14s/releases/download/v${TF_K14S_PLUGIN_VERSION}/terraform-provider-k14s-binaries.tgz" && \
tar xzvf terraform-provider-k14s-binaries.tgz -C ~/.terraform.d/plugins/registry.terraform.io/hashicorp/k14s/$TF_K14S_PLUGIN_VERSION && \
rm -Rf terraform-provider-k14s-binaries.tgz

TMC_VERSION=0.2.0-33567c83 && \
wget -O tmc https://vmware.bintray.com/tmc/${TMC_VERSION}/linux/x64/tmc && \
chmod +x tmc && \
sudo mv tmc /usr/local/bin

PIVNET_VERSION=3.0.1 && \
wget -O pivnet https://github.com/pivotal-cf/pivnet-cli/releases/download/v${PIVNET_VERSION}/pivnet-linux-amd64-${PIVNET_VERSION} && \
chmod +x pivnet && \
sudo mv pivnet /usr/local/bin

curl -LO https://dl.min.io/client/mc/release/linux-amd64/mc && \
chmod +x mc && \
sudo mv mc /usr/local/bin