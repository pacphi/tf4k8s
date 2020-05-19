#!/bin/bash

cd ../../../ytt-libs/cf4k8s || exit
vendir sync
cd ../../experiments/k8s/cf4k8s || exit
terraform init
terraform validate
terraform graph | dot -Tsvg > graph.svg
terraform plan
terraform apply -auto-approve