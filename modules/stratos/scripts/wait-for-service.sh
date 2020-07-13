#!/bin/bash

# Credit goes to https://github.com/Logimethods/cf-cli-resource/blob/master/assets/cf-functions.sh

service_instance=$1
timeout=${2:-600}

guid=$(cf service "$service_instance" --guid)
start=$(date +%s)

echo "Waiting for service: $service_instance"
while true; do
    # Get the service instance info in JSON from CC and parse out the async 'state'
    state=$(cf curl "/v2/service_instances/$guid" | jq -r .entity.last_operation.state)

    if [ "$state" = "succeeded" ]; then
        echo "Service $service_instance is ready"
        return
    elif [ "$state" = "failed" ]; then
        echo "Service $service_instance failed to provision:"
        cf curl "/v2/service_instances/$guid" | jq -r .entity.last_operation.description
        exit 1
    fi

    now=$(date +%s)
    time=$(($now - $start))
    if [[ "$time" -ge "$timeout" ]]; then
        echo "Timed out waiting for service instance to provision: $service_instance"
        exit 1
    fi
    sleep 5
done
