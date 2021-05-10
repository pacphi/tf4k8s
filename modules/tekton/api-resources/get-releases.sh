#!/bin/bash

TEKTON_PIPELINES_VERSION="v0.23.0"
TEKTON_DASHBOARD_VERSION="v0.16.1"

curl -LO https://github.com/tektoncd/pipeline/releases/download/${TEKTON_PIPELINES_VERSION}/release.yaml
curl -LO https://github.com/tektoncd/dashboard/releases/download/${TEKTON_DASHBOARD_VERSION}/tekton-dashboard-release.yaml

# Remove the last N lines of the file

N=3
head -n $(( $(wc -l release.yaml | awk '{print $1}') - $N )) release.yaml > release.yaml.new
head -n $(( $(wc -l tekton-dashboard-release.yaml | awk '{print $1}') - $N )) tekton-dashboard-release.yaml > tekton-dashboard-release.yaml.new

rm release.yaml
rm tekton-dashboard-release.yaml

mv release.yaml.new release.yaml
mv tekton-dashboard-release.yaml.new tekton-dashboard-release.yaml