#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: create-dockerfile.sh {iaas}"
	exit 1
fi

IAAS="$1"
ARTIFACT_DIR="dist/${IAAS}"

cat << EOF > Dockerfile

FROM alpine:3.22.2

COPY ${ARTIFACT_DIR}/cloud-service-broker /bin/cloud-service-broker
COPY ${ARTIFACT_DIR}/*.brokerpak /${IAAS}-brokerpak/
COPY ${ARTIFACT_DIR}/version /${IAAS}-brokerpak/version

ENV PORT 8080
EXPOSE 8080/tcp

WORKDIR /bin
ENTRYPOINT ["/bin/cloud-service-broker"]
CMD ["help"]

EOF
