#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y build-essential git gnupg libnss3-tools zlibc zlib1g-dev ruby ruby-dev openssl libxslt1-dev libxml2-dev libssl-dev libreadline7 libreadline-dev libyaml-dev libsqlite3-dev sqlite3
sudo apt-get install -y snapd unzip graphviz wget

sudo snap install snap-store

sudo snap install aws-cli --classic
sudo snap install google-cloud-sdk --classic
sudo snap install code --classic
sudo snap install doctl
sudo snap install kubectl --classic
sudo snap install helm --classic
sudo snap install http
sudo snap install k9s

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

HELMFILE_VERSION=0.125.7
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

curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/aws-iam-authenticator
chmod +x aws-iam-authenticator
sudo mv aws-iam-authenticator /usr/local/bin

OCTANT_VERSION=0.15.0
wget https://github.com/vmware-tanzu/octant/releases/download/v${OCTANT_VERSION}/octant_${OCTANT_VERSION}_Linux-64bit.deb
sudo dpkg -i octant_${OCTANT_VERSION}_Linux-64bit.deb

YTT_VERSION=0.30.0
wget -O ytt https://github.com/k14s/ytt/releases/download/v${YTT_VERSION}/ytt-linux-amd64 && \
chmod +x ytt && \
sudo mv ytt /usr/local/bin

VENDIR_VERSION=0.9.0
wget -O vendir https://github.com/k14s/vendir/releases/download/v${VENDIR_VERSION}/vendir-linux-amd64 && \
chmod +x vendir && \
sudo mv vendir /usr/local/bin

KAPP_VERSION=0.34.0
wget -O kapp https://github.com/k14s/kapp/releases/download/v${KAPP_VERSION}/kapp-linux-amd64 && \
chmod +x kapp && \
sudo mv kapp /usr/local/bin

KBLD_VERSION=0.24.0
wget -O kbld https://github.com/k14s/kbld/releases/download/v${KBLD_VERSION}/kbld-linux-amd64 && \
chmod +x kbld && \
sudo mv kbld /usr/local/bin

curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh | bash

# Install Terraform k14s provider; @see https://github.com/k14s/terraform-provider-k14s
TF_K14S_PLUGIN_VERSION=0.6.0 && \
mkdir -p ~/.terraform.d/plugins && \
curl -LO "https://github.com/k14s/terraform-provider-k14s/releases/download/v${TF_K14S_PLUGIN_VERSION}/terraform-provider-k14s-binaries.tgz" && \
tar xzvf terraform-provider-k14s-binaries.tgz -C ~/.terraform.d/plugins/ && \
rm -Rf terraform-provider-k14s-binaries.tgz

ALIYUN_VERSION=3.0.56 && \
curl -LO "https://github.com/aliyun/aliyun-cli/releases/download/v${ALIYUN_VERSION}/aliyun-cli-linux-${ALIYUN_VERSION}-amd64.tgz" && \
sudo tar xzvf aliyun-cli-linux-${ALIYUN_VERSION}-amd64.tgz -C /usr/local/bin && \
rm -Rf aliyun-cli-linux-${ALIYUN_VERSION}-amd64.tgz

BOSH_VERSION=6.3.1 && \
wget -O bosh https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-${BOSH_VERSION}-linux-amd64 && \
chmod +x bosh && \
sudo mv bosh /usr/local/bin

PIVNET_VERSION=2.0.0 && \
wget -O pivnet https://github.com/pivotal-cf/pivnet-cli/releases/download/v${PIVNET_VERSION}/pivnet-linux-amd64-${PIVNET_VERSION} && \
chmod +x pivnet && \
sudo mv pivnet /usr/local/bin

ARGOCD_VERSION=1.7.3 && \
curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/v${ARGOCD_VERSION}/argocd-linux-amd64 && \
chmod +x /usr/local/bin/argocd
ARGO_ROLLOUTS_VERSION=0.9.0
curl -sSL -o /usr/local/bin/kubectl-argo-rollouts https://github.com/argoproj/argo-rollouts/releases/download/v${ARGO_ROLLOUTS_VERSION}/kubectl-argo-rollouts-linux-amd64 && \
chmod +x /usr/local/bin/kubectl-argo-rollouts

TEKTON_VERSION=0.11.0 && \
curl -LO https://github.com/tektoncd/cli/releases/download/v${TEKTON_VERSION}/tkn_${TEKTON_VERSION}_Linux_x86_64.tar.gz && \
sudo tar xvzf tkn_${TEKTON_VERSION}_Linux_x86_64.tar.gz -C /usr/local/bin/ tkn

wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add -
echo "deb https://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list

sudo apt-get update -y
sudo apt-get install -y cf-cli

# @see https://krew.sigs.k8s.io/docs/user-guide/setup/install/
set -x; cd "$(mktemp -d)" &&
curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.{tar.gz,yaml}" &&
tar zxvf krew.tar.gz &&
KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" &&
"$KREW" install --manifest=krew.yaml --archive=krew.tar.gz &&
"$KREW" update

curl -Lo ./kind "https://kind.sigs.k8s.io/dl/v0.8.1/kind-$(uname)-amd64" &&
chmod +x kind &&
sudo mv kind /usr/local/bin

cd /tmp
git clone https://github.com/FiloSottile/mkcert && cd mkcert
go build -ldflags "-X main.Version=$(git describe --tags)"
sudo mv mkcert /usr/local/bin

curl -LO https://dl.min.io/client/mc/release/linux-amd64/mc &&
chmod +x mc &&
sudo mv mc /usr/local/bin