#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ]; then
	echo "Usage: delete-gce-vm.sh {instance-name} {project-id} {availability-zone}"
	echo "-- for example: ./delete-gce-vm.sh microk8s-demo fe-cphillipson us-west1-a"
    exit 1
fi

INSTANCE_NAME="$1"
GCP_PROJECT="$2"
AVAILABILITY_ZONE="$3"

gcloud compute instances delete ${INSTANCE_NAME} --project=${GCP_PROJECT} --zone=${AVAILABILITY_ZONE}
