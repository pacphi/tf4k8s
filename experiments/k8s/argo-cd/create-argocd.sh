#!/bin/bash

terraform init
terraform validate
terraform graph | dot -Tsvg > graph.svg
terraform plan -out terraform.plan
terraform apply -auto-approve -state terraform.tfstate terraform.plan

# @ see https://argoproj.github.io/argo-cd/getting_started/#4-login-using-the-cli
ARGOCD_PASSWD=$(kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2)
echo "Initial password for your Argo CD server is [ ${ARGOCD_PASSWD} ]"