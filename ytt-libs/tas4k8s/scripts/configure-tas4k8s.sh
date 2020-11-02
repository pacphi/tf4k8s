#!/bin/bash

if [ -z "$1" ]; then
  	VENDOR_DIR="vendor"
else
	VENDOR_DIR="$1"
fi

TAS_INSTALL_DIR=/tmp/tanzu-application-service

mkdir -p $VENDOR_DIR/configuration-values
# Replace bin/generate-values.sh from TAS 3 with custom script that does NOT setup cf_admin_password, system-certificate, workloads-certificate values
mv $TAS_INSTALL_DIR/bin/generate-values.sh $TAS_INSTALL_DIR/bin/generate-values.sh.original
cp -f scripts/generate-values.sh $TAS_INSTALL_DIR/bin

# Copy config into place
cp -Rf $TAS_INSTALL_DIR/bin $VENDOR_DIR
cp -Rf $TAS_INSTALL_DIR/config $VENDOR_DIR
cp -Rf $TAS_INSTALL_DIR/config-optional $VENDOR_DIR
