#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ] && [ -z "$4" ] && [ -z "$5" ] && [ -z "$6" ]; then
	echo "Usage: configure-tsmgr-prerequisites.sh {harbor_domain} {harbor_username} {harbor_password} {s3_endpoint} {s3_access_key} {s3_secret_key}"
	exit 1
fi

HARBOR_DOMAIN="$1"
HARBOR_USERNAME="$2"
HARBOR_PASSWORD="$3"
S3_ENDPOINT="$4"
S3_ACCESS_KEY="$5"
S3_SECRET_KEY="$6"

VERSION=0.11.8
PREFIX=tanzu-service-manager
S3_BUCKET_NAME=${PREFIX}-offerings

echo "- Creating a project named ${PREFIX} in Harbor"
PAYLOAD="{  \"project_name\": \"${PREFIX}\", \"metadata\": { \"enable_content_trust\": \"true\", \"auto_scan\": \"false\", \"severity\": \"none\", \"reuse_sys_cve_whitelist\": \"false\", \"public\": \"true\", \"prevent_vul\": \"false\" }, \"storage_limit\": -1 }"
curl -X POST -u "${HARBOR_USERNAME}:${HARBOR_PASSWORD}" -H "Content-Type: application/json" -k -i -v -d "${PAYLOAD}" https://${HARBOR_DOMAIN}/api/v2.0/projects

echo "- Creating a project named ${PREFIX}-si in Harbor"
PAYLOAD="{  \"project_name\": \"${PREFIX}-si\", \"metadata\": { \"enable_content_trust\": \"true\", \"auto_scan\": \"false\", \"severity\": \"none\", \"reuse_sys_cve_whitelist\": \"false\", \"public\": \"true\", \"prevent_vul\": \"false\" }, \"storage_limit\": -1 }"
curl -X POST -u "${HARBOR_USERNAME}:${HARBOR_PASSWORD}" -H "Content-Type: application/json" -k -i -v -d "${PAYLOAD}" https://${HARBOR_DOMAIN}/api/v2.0/projects

sleep 5

echo "- Tagging TSMGR container images"

docker tag registry.pivotal.io/${PREFIX}/broker:${VERSION} \
 ${HARBOR_DOMAIN}/${PREFIX}/broker:${VERSION}

docker tag registry.pivotal.io/${PREFIX}/daemon:${VERSION} \
 ${HARBOR_DOMAIN}/${PREFIX}/daemon:${VERSION}

docker tag registry.pivotal.io/${PREFIX}/chartmuseum:${VERSION} \
 ${HARBOR_DOMAIN}/${PREFIX}/chartmuseum:${VERSION}

docker tag registry.pivotal.io/${PREFIX}/minio:${VERSION} \
 ${HARBOR_DOMAIN}/${PREFIX}/minio:${VERSION}

echo "- Publishing container images to Harbor"
docker login -u "${HARBOR_USERNAME}" -p "${HARBOR_PASSWORD}" ${HARBOR_DOMAIN}
export DOCKER_CONTENT_TRUST=1
NOTARY_DOMAIN="${HARBOR_DOMAIN/harbor/notary}"
export DOCKER_CONTENT_TRUST_SERVER=https://${NOTARY_DOMAIN}
export DOCKER_CONTENT_TRUST_REPOSITORY_PASSPHRASE=${HARBOR_PASSWORD}
export DOCKER_CONTENT_TRUST_ROOT_PASSPHRASE=${HARBOR_PASSWORD}
docker push ${HARBOR_DOMAIN}/${PREFIX}/broker:${VERSION}
docker push ${HARBOR_DOMAIN}/${PREFIX}/daemon:${VERSION}
docker push ${HARBOR_DOMAIN}/${PREFIX}/chartmuseum:${VERSION}
docker push ${HARBOR_DOMAIN}/${PREFIX}/minio:${VERSION}
unset DOCKER_CONTENT_TRUST


echo "- Create bucket named ${S3_BUCKET_NAME} @ ${S3_ENDPOINT}"

mc alias set minio https://${S3_ENDPOINT} ${S3_ACCESS_KEY} ${S3_SECRET_KEY}
mc mb minio/${S3_BUCKET_NAME}