#!/bin/bash

CLI_VERSION="v0.12.5"

curl -LO https://github.com/bitnami-labs/sealed-secrets/releases/download/${CLI_VERSION}/kubeseal-linux-amd64
mv kubeseal-linux-amd64 kubeseal
chmod +x kubeseal
sudo mv kubeseal /usr/local/bin
