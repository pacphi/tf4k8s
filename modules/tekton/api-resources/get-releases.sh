#!/bin/bash

TEKTON_PIPELINES_VERSION="v0.28.1"
TEKTON_DASHBOARD_VERSION="v0.21.0"

curl -LO https://github.com/tektoncd/pipeline/releases/download/${TEKTON_PIPELINES_VERSION}/release.yaml
curl -LO https://github.com/tektoncd/dashboard/releases/download/${TEKTON_DASHBOARD_VERSION}/tekton-dashboard-release.yaml

# Remove the last N lines of the file

N=2
head -n $(( $(wc -l release.yaml | awk '{print $1}') - $N )) release.yaml > release.yaml.new

rm release.yaml

mv release.yaml.new release.yaml
