#!/bin/bash

# Install Homebrew; @see https://brew.sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install minimal complement of tools
brew install awscli aws-iam-authenticator aliyun-cli azure-cli doctl git gpg graphviz libressl mkcert nss openssl terraform terraform-docs tflint httpie kind kubernetes-cli helm helmfile krew octant

brew cask install google-cloud-sdk keybase

brew tap k14s/tap
brew install ytt kbld kapp imgpkg kwt vendir
brew install derailed/k9s/k9s

brew install jpoon/homebrew-oci-cli/oci-cli

brew install cloudfoundry/tap/bosh-cli
brew install pivotal/tap/pivnet-cli

brew install cloudfoundry/tap/cf-cli@7

brew tap argoproj/tap
brew install argoproj/tap/argocd
brew install argoproj/tap/kubectl-argo-rollouts

brew tap tektoncd/tools
brew install tektoncd/tools/tektoncd-cli

brew install minio/stable/mc

# Install Terraform k14s provider; @see https://github.com/k14s/terraform-provider-k14s
TF_K14S_PLUGIN_VERSION=0.6.0 && \
mkdir -p ~/.terraform.d/plugins && \
curl -LO "https://github.com/k14s/terraform-provider-k14s/releases/download/v${TF_K14S_PLUGIN_VERSION}/terraform-provider-k14s-binaries.tgz" && \
tar xzvf terraform-provider-k14s-binaries.tgz -C ~/.terraform.d/plugins/registry.terraform.io/hashicorp/k14s/$TF_K14S_PLUGIN_VERSION
rm -Rf terraform-provider-k14s-binaries.tgz

TMC_VERSION=0.1.0-829a6124 && \
wget -O tmc https://vmware.bintray.com/tmc/${TMC_VERSION}/darwin/x64/tmc && \
chmod +x tmc && \
sudo mv tmc /usr/local/bin
