#!/bin/bash

CNR_INSTALLATION_NAME="cloud-native-runtimes"
kapp delete -n ${CNR_INSTALLATION_NAME} -a ${CNR_INSTALLATION_NAME} -y
kubectl delete ns ${CNR_INSTALLATION_NAME}
