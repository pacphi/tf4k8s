#!/bin/bash

BUILD_SERVICE_INSTALLATION_NAME="tanzu-build-service"
kapp delete -a ${BUILD_SERVICE_INSTALLATION_NAME} -y
