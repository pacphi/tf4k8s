#!/bin/bash

# Install Homebrew; @see https://brew.sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install minimal complement of tools
brew install awscli aliyun-cli azure-cli doctl git graphviz terraform tflint httpie kubernetes-cli helm helmfile octant

brew cask install google-cloud-sdk
brew tap k14s/tap
brew install ytt kbld kapp imgpkg kwt vendir
brew install derailed/k9s/k9s

brew install jpoon/homebrew-oci-cli/oci-cli

brew install cloudfoundry/tap/bosh-cli
brew install pivotal/tap/pivnet-cli

# Install Terraform k14s provider; @see https://github.com/k14s/terraform-provider-k14s
TF_K14S_PLUGIN_VERSION=0.4.0 && \
mkdir -p ~/.terraform.d/plugins && \
curl -LO "https://github.com/k14s/terraform-provider-k14s/releases/download/v${TF_K14S_PLUGIN_VERSION}/terraform-provider-k14s-binaries.tgz" && \
tar xzvf terraform-provider-k14s-binaries.tgz -C ~/.terraform.d/plugins/
rm -Rf terraform-provider-k14s-binaries.tgz
