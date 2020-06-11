#!/bin/bash

# Cleanup
FILENAME=$(find . -type f -name "tanzu-application-service.*" -print | head -n 1)
rm -f "$FILENAME"
rm -Rf /tmp/tanzu-application-service