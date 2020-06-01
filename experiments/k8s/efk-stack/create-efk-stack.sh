#!/bin/bash

rm -Rf ../../../ytt-libs/fluentbit/vendor
rm -f ../../../ytt-libs/fluentbit/vendir.lock.yml

# Fetch specific commit from https://github.com/fluent/fluent-bit-kubernetes-logging
cd ../../../ytt-libs/fluentbit || exit
vendir sync

cd ../../experiments/k8s/efk-stack || exit

terraform init
terraform validate
terraform graph | dot -Tsvg > graph.svg
terraform plan
terraform apply -auto-approve
