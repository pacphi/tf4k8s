#!/bin/bash

# Install Homebrew; @see https://brew.sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install minimal complement of tools
brew install awscli aliyun-cli azure-cli doctl git terraform tflint httpie kubernetes-cli helm helmfile octant

brew cask install google-cloud-sdk
brew tap k14s/tap
brew install ytt kbld kapp imgpkg kwt vendir

brew install jpoon/homebrew-oci-cli/oci-cli
