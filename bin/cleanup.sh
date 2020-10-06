#!/bin/bash
# Destroys all Terraform artifacts, directories and files under experiments and its subdirectories

set -e

if [ -z "$1" ]; then
	echo "Usage: ./bin/cleanup.sh {iaas}"
	exit 1
fi

IAAS="$1"

EXPERIMENTS=( "certmanager" "cluster" "dns" "external-dns" )
K8S_MODULES=( "argo-cd" "cf4k8s" "concourse" "contour" "efk-stack" "gitea" "flagger" "harbor" "jcr" "loki-stack" "minio" "pivotal-csb" "nginx-ingress" "stratos" "tas4k8s" "tsmgr" "tekton" "wavefront" )
PAAS_MODULES=( "cf4k8s" "tas4k8s" )

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

cd ../../modules
for i in "${PAAS_MODULES[@]}"
do
  cd "$i"
  rm -Rf *.tfvars
  rm -Rf acme/$IAAS/*.tfvars acme/$IAAS/.terraform acme/$IAAS/terraform.tfstate* acme/$IAAS/terraform.log
  cd ..
done

cd ../ytt-libs
for i in "${PAAS_MODULES[@]}"
do
  cd "$i"
  rm -Rf vendor
  cd ..
done