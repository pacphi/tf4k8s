#!/bin/bash

sudo apt update -y
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common build-essential git gnupg zlibc zlib1g-dev ruby ruby-dev openssl libxslt1-dev libxml2-dev libssl-dev libreadline7 libreadline-dev libyaml-dev libsqlite3-dev sqlite3
sudo apt install -y snapd unzip graphviz wget

sudo snap install snap-store

sudo snap install kubectl --classic
sudo snap install helm --classic
sudo snap install http

HELMFILE_VERSION=0.119.1
curl -Lo ./helmfile https://github.com/roboll/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_linux_amd64
sudo mv helmfile /usr/local/bin

TERRAFORM_VERSION=0.12.28
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo mv terraform /usr/local/bin

curl -L "$(curl -Ls https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")" -o tflint.zip && unzip tflint.zip && rm tflint.zip

TERRAFORM_DOCS_VERSION=0.9.1
curl -Lo ./terraform-docs https://github.com/segmentio/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-$(uname | tr '[:upper:]' '[:lower:]')-amd64
chmod +x ./terraform-docs
sudo mv terraform-docs /usr/local/bin

/bin/bash -c "$(curl -fsSL https://k14s.io/install.sh)"

# Install Terraform k14s provider; @see https://github.com/k14s/terraform-provider-k14s
TF_K14S_PLUGIN_VERSION=0.6.0 && \
mkdir -p ~/.terraform.d/plugins && \
curl -LO "https://github.com/k14s/terraform-provider-k14s/releases/download/v${TF_K14S_PLUGIN_VERSION}/terraform-provider-k14s-binaries.tgz" && \
tar xzvf terraform-provider-k14s-binaries.tgz -C ~/.terraform.d/plugins/ && \
rm -Rf terraform-provider-k14s-binaries.tgz

BOSH_VERSION=6.3.0 && \
wget -O bosh https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-${BOSH_VERSION}-linux-amd64 && \
chmod +x bosh && \
sudo mv bosh /usr/local/bin

PIVNET_VERSION=1.0.4 && \
wget -O pivnet https://github.com/pivotal-cf/pivnet-cli/releases/download/v${PIVNET_VERSION}/pivnet-linux-amd64-${PIVNET_VERSION} && \
chmod +x pivnet && \
sudo mv pivnet /usr/local/bin

ARGOCD_VERSION=1.6.1 && \
curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/v${ARGOCD_VERSION}/argocd-linux-amd64 && \
chmod +x /usr/local/bin/argocd

TEKTON_VERSION=0.10.0 && \
curl -LO https://github.com/tektoncd/cli/releases/download/v${TEKTON_VERSION}/tkn_${TEKTON_VERSION}_Linux_x86_64.tar.gz && \
sudo tar xvzf tkn_${TEKTON_VERSION}_Linux_x86_64.tar.gz -C /usr/local/bin/ tkn

wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add -
echo "deb https://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list

sudo apt update -y
sudo apt install -y cf-cli

# @see https://krew.sigs.k8s.io/docs/user-guide/setup/install/
set -x; cd "$(mktemp -d)" &&
curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.{tar.gz,yaml}" &&
tar zxvf krew.tar.gz &&
KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" &&
"$KREW" install --manifest=krew.yaml --archive=krew.tar.gz &&
"$KREW" update

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install -y docker-ce
sudo usermod -aG docker ${USER}

echo "Installation completed... please log out and log back in"