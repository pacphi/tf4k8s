#!/bin/bash

terraform destroy -auto-approve
rm -f ../../../modules/cf4k8s/templates/config.yml
rm -Rf ../../../ytt-libs/cf4k8s/vendor
rm -f ../../../ytt-libs/cf4k8s/vendir.lock.yml

# rm -Rf ./terraform terraform.log terraform.tfstate* graph.svg