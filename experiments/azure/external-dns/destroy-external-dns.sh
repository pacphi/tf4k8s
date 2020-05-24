#!/bin/bash

terraform destroy -auto-approve

rm -Rf ../../../modules/external-dns/azure/vendor
rm -f ../../../modules/external-dns/azure/vendir.lock.yml
