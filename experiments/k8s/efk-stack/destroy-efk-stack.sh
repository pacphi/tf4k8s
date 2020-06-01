#!/bin/bash

terraform destroy -auto-approve

rm -Rf ../../../ytt-libs/fluentbit/vendor
rm -f ../../../ytt-libs/fluentbit/vendir.lock.yml
