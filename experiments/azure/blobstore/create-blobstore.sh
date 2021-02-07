#!/bin/bash

terraform init
terraform validate
terraform graph | dot -Tsvg > graph.svg
terraform plan -out terraform.plan
terraform apply -state terraform.tfstate terraform.plan -auto-approve
