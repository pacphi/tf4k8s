#!/bin/bash

terraform init
terraform validate
terraform graph | dot -Tsvg > graph.svg
terraform plan -out terraform.plan
terraform apply -auto-approve -state terraform.tfstate terraform.plan

# Necessarily evil re-attempt
terraform plan -out terraform.plan
terraform apply -auto-approve -state terraform.tfstate terraform.plan