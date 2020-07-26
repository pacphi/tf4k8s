#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ] && [ -z "$4" ] && [ -z "$5" ] && [ -z "$6" ] && [ -z "$7" ] && [ -z "$8" ] && [ -z "$9" ]; then
	echo "Usage: create-gce-vm.sh {project-id} {instance-name} {availability-zone} {machine-type} {service-account} {os-image} {os-image-project} {disk-size} {is-preemptible}"
	echo "-- for example: ./create-gce-vm.sh fe-cphillipson microk8s-demo us-west1-a e2-standard-16 1038246944987-compute@developer.gserviceaccount.com ubuntu-minimal-2004-focal-v20200702 ubuntu-os-cloud 500 true"
    exit 1
fi

GCP_PROJECT="$1"
INSTANCE_NAME="$2"
AVAILABILITY_ZONE="$3"
MACHINE_TYPE="$4"
SERVICE_ACCOUNT="$5"
OS_IMAGE="$6"
OS_IMAGE_PROJECT="$7"
DISK_SIZE="$8"
IS_PREEMPTIBLE="$9"

if [ "$IS_PREEMPTIBLE" == "true" ] || [ "$IS_PREMEEMPTIBLE" == "True" ] || [ "$IS_PREEMPTIBLE" == "TRUE" ]; then
    gcloud beta compute --project="${GCP_PROJECT}" instances create "${INSTANCE_NAME}" \
        --zone="${AVAILABILITY_ZONE}" --machine-type=${MACHINE_TYPE} --subnet=default \
        --network-tier=PREMIUM --no-restart-on-failure --maintenance-policy=TERMINATE \
        --preemptible --service-account="${SERVICE_ACCOUNT}" \
        --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
        --image="${OS_IMAGE}" --image-project="${OS_IMAGE_PROJECT}" \
        --boot-disk-type=pd-standard --boot-disk-device-name=${INSTANCE_NAME}-boot-disk --no-shielded-secure-boot \
        --create-disk=mode=rw,size=${DISK_SIZE},type=projects/${GCP_PROJECT}/zones/${AVAILABILITY_ZONE}/diskTypes/pd-standard,name=${INSTANCE_NAME}-disk-1,device-name=${INSTANCE_NAME}-disk-1 \
        --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any
else
    gcloud beta compute --project="${GCP_PROJECT}" instances create "${INSTANCE_NAME}" \
        --zone="${AVAILABILITY_ZONE}" --machine-type=${MACHINE_TYPE} --subnet=default \
        --network-tier=PREMIUM --no-restart-on-failure \
        --service-account="${SERVICE_ACCOUNT}" \
        --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
        --image="${OS_IMAGE}" --image-project="${OS_IMAGE_PROJECT}" \
        --boot-disk-type=pd-standard --boot-disk-device-name=${INSTANCE_NAME}-boot-disk --no-shielded-secure-boot \
        --create-disk=mode=rw,size=${DISK_SIZE},type=projects/${GCP_PROJECT}/zones/${AVAILABILITY_ZONE}/diskTypes/pd-standard,name=${INSTANCE_NAME}-disk-1,device-name=${INSTANCE_NAME}-disk-1 \
        --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any
fi