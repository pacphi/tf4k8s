#!/bin/bash

terraform destroy -auto-approve

rm -Rf ../../../ytt-libs/tas4k8s/vendor
rm -f ../../../ytt-libs/tas4k8s/vendir.lock.yml
