#!/bin/bash

if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
  exit 1
fi

# Modular Terraform for invoking Terraform to get a simple Kuberenetes dial-tone on popular cloud provider platforms
git clone https://github.com/hajowieland/terraform-kubernetes-multi-cloud.git

# Source repositories for Terraforming Kubenretes cluster on individual cloud provider platforms
git clone https://github.com/hajowieland/terraform-alicloud-k8s # Alibaba
git clone https://github.com/hajowieland/terraform-aws-k8s # Amazon Web Services
git clone https://github.com/hajowieland/terraform-azurerm-k8s # Microsft Azure
git clone https://github.com/hajowieland/terraform-digitalocean-k8s # Digital Ocean
git clone https://github.com/hajowieland/terraform-google-k8s # Google Cloud Platform
git clone https://github.com/hajowieland/terraform-oci-k8s # Oracle Cloud Infrastructure