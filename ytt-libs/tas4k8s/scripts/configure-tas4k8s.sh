#!/bin/bash

YTT_LIB_DIR="${PWD}"

if [ -z "$1" ]; then
  	VENDOR_DIR="vendor"
else
	VENDOR_DIR="$1"
fi

TAS_INSTALL_DIR=/tmp/tanzu-application-service

mkdir -p $TAS_INSTALL_DIR/configuration-values
# Replace bin/generate-values.sh from TAS 3 with custom script that does NOT setup cf_admin_password, system-certificate, workloads-certificate values
cp -f scripts/generate-values.sh $TAS_INSTALL_DIR/bin
cd $TAS_INSTALL_DIR || exit
# Generate initial configuration values
./bin/generate-values.sh configuration-values
# Detect cluster type, set cluster-specific values
./bin/cluster-detect.sh > configuration-values/cluster-values.yml
cd "${YTT_LIB_DIR}" || exit

# Copy config into place
mkdir -p $VENDOR_DIR
cp -Rf /tmp/tanzu-application-service/config $VENDOR_DIR
cp -Rf /tmp/tanzu-application-service/config-optional $VENDOR_DIR
cp -Rf /tmp/tanzu-application-service/configuration-values $VENDOR_DIR
