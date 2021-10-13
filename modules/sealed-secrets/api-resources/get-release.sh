#!/bin/bash

SEALED_SECRETS_VERSION="v0.16.0"

curl -LO https://github.com/bitnami-labs/sealed-secrets/releases/download/${SEALED_SECRETS_VERSION}/controller.yaml
