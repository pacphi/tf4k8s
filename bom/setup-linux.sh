#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y build-essential zlibc zlib1g-dev ruby ruby-dev openssl libxslt1-dev libxml2-dev libssl-dev libreadline7 libreadline-dev libyaml-dev libsqlite3-dev sqlite3
sudo apt-get install -y snapd unzip graphviz wget

sudo snap install snap-store

sudo snap install aws-cli --classic
sudo snap install google-cloud-sdk --classic
sudo snap install code --classic
sudo snap install git-ubuntu --classic
sudo snap install azure-cli --candidate
sudo snap install doctl
sudo snap install terraform
sudo snap install kubectl --classic
sudo snap install helm --classic
sudo snap install helmfile-snap
sudo snap install http
sudo snap install k9s

curl -L "$(curl -Ls https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")" -o tflint.zip && unzip tflint.zip && rm tflint.zip

wget https://github.com/vmware-tanzu/octant/releases/download/v0.9.1/octant_0.9.1_Linux-64bit.deb
dpkg -i octant_0.9.1_Linux-64bit.deb

curl -L https://k14s.io/install.sh | bash

curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh | bash

# Install Terraform k14s provider; @see https://github.com/k14s/terraform-provider-k14s
TF_K14S_PLUGIN_VERSION=0.4.0 && \
mkdir -p ~/.terraform.d/plugins && \
curl -LO "https://github.com/k14s/terraform-provider-k14s/releases/download/v${TF_K14S_PLUGIN_VERSION}/terraform-provider-k14s-binaries.tgz" && \
tar xzvf terraform-provider-k14s-binaries.tgz -C ~/.terraform.d/plugins/ && \
rm -Rf terraform-provider-k14s-binaries.tgz

ALIYUN_VERSION=3.0.44 && \
curl -LO "https://github.com/aliyun/aliyun-cli/releases/download/v${ALIYUN_VERSION}/aliyun-cli-linux-${ALIYUN_VERSION}-amd64.tgz" && \
sudo tar xzvf aliyun-cli-linux-${ALIYUN_VERSION}-amd64.tgz -C /usr/local/bin && \
rm -Rf aliyun-cli-linux-${ALIYUN_VERSION}-amd64.tgz

BOSH_VERSION=6.2.1 && \
wget -O bosh https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-${BOSH_VERSION}-linux-amd64 && \
chmod +x bosh && \
sudo mv bosh /usr/local/bin

PIVNET_VERSION=1.0.3 && \
wget -O pivnet https://github.com/pivotal-cf/pivnet-cli/releases/download/v${PIVNET_VERSION}/pivnet-linux-amd64-${PIVNET_VERSION} && \
chmod +x pivnet && \
sudo mv pivnet /usr/local/bin
