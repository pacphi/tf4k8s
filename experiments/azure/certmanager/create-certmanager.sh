#!/bin/bash

terraform init
terraform validate
terraform graph | dot -Tsvg > graph.svg
terraform plan
terraform apply -auto-approve

# Necessarily evil re-attempt
terraform plan
terraform apply -auto-approve