#!/bin/bash

set -e

if [ -z "$1" ]; then
	echo "Usage: ./bin/cleanup.sh {iaas}"
	exit 1
fi

IAAS="$1"
# Destroys all Terraform artifacts, directories and files under experiments and its subdirectories

cd experiments
cd "${IAAS}"
cd certmanager
rm -Rf .terraform terraform.tfstate* terraform.log graph.svg
cd ../cluster
rm -Rf .terraform terraform.tfstate* terraform.log graph.svg
cd ../dns
rm -Rf .terraform terraform.tfstate* terraform.log graph.svg
cd ../external-dns
rm -Rf .terraform terraform.tfstate* terraform.log graph.svg
cd ../..
cd k8s
cd cf4k8s
rm -Rf .terraform terraform.tfstate* terraform.log graph.svg
cd ../tas4k8s
rm -Rf .terraform terraform.tfstate* terraform.log graph.svg
cd ../harbor
rm -Rf .terraform terraform.tfstate* terraform.log graph.svg
cd ../nginx-ingress
rm -Rf .terraform terraform.tfstate* terraform.log graph.svg

