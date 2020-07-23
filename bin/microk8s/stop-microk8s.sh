#!/bin/bash

echo "Stopping microk8s..."

multipass exec kube-master -- sudo /snap/bin/microk8s.stop

echo "Next step..."
echo "-- at a time that's convenient, you may wish to restart microk8s with [ startup-microk8s.sh ]"
