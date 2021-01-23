#!/bin/bash

terraform destroy -auto-approve
rm -Rf .terraform .terraform.lock.hcl terraform.tfstate terraform.tfstate.backup terraform.log graph.svg
