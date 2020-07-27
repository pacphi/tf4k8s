#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ]; then
	echo "Usage: connect-gce-vm.sh {instance-name} {project-id} {availability-zone}"
	echo "-- for example: ./connect-gce-vm.sh microk8s-demo fe-cphillipson us-west1-a"
    exit 1
fi

INSTANCE_NAME="$1"
GCP_PROJECT="$2"
AVAILABILITY_ZONE="$3"

gcloud beta compute ssh --zone "${AVAILABILITY_ZONE}" "${INSTANCE_NAME}" --project "${GCP_PROJECT}"
