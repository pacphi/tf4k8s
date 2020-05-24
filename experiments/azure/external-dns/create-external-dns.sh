#!/bin/bash

cd ../../../modules/external-dns/azure/ || exit
vendir sync
cd ../../../experiments/azure/external-dns || exit

terraform init
terraform validate
terraform graph | dot -Tsvg > graph.svg
terraform plan
terraform apply -auto-approve