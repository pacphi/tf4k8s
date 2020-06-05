#!/bin/bash
# Destroys all Terraform artifacts, directories and files under experiments and its subdirectories

set -e

if [ -z "$1" ]; then
	echo "Usage: ./bin/cleanup.sh {iaas}"
	exit 1
fi

IAAS="$1"

EXPERIMENTS=( "certmanager" "cluster" "dns" "external-dns" )
K8S_MODULES=( "cf4k8s" "efk-stack" "harbor" "loki-stack" "nginx-ingress" "tas4k8s" "wavefront" )

cd experiments
cd "${IAAS}"
# @see https://www.cyberciti.biz/faq/bash-for-loop-array/
for i in "${EXPERIMENTS[@]}"
do
  cd "$i"
  rm -Rf .terraform/ terraform.tfstate* terraform.log graph.svg
  cd ..
done

cd ../k8s
for i in "${K8S_MODULES[@]}"
do
  cd $i
  rm -Rf .terraform/ terraform.tfstate* terraform.log graph.svg
  cd ..
done
