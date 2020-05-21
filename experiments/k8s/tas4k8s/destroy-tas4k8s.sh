#!/bin/bash

terraform destroy -auto-approve
rm -f ../../../modules/tas4k8s/templates/config.yml
rm -Rf ../../../ytt-libs/tas4k8s/vendor
rm -f ../../../ytt-libs/tas4k8s/vendir.lock.yml

# rm -Rf ./terraform terraform.log terraform.tfstate* graph.svg