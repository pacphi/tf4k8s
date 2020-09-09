#!/bin/bash

# Use https://github.com/k14s/vendir to synchronize resources
# Remove all prior synchronized resources first
rm -Rf vendor vendir.lock.yml
vendir sync
