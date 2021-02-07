#!/bin/bash

terraform init
terraform validate
terraform plan -out terraform.plan
terraform apply -state terraform.tfstate terraform.plan -auto-approve
