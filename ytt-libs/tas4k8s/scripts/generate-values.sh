#!/usr/bin/env bash

# Modified variant of bin/generate-values.sh script packaged with tas4k8s

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null 2>&1 && cd .. && pwd)"
CONFIG_VALUES_DIR="${1}"
function main() {
  generate_bosh_vars
}

function generate_bosh_vars() {
  VARS_STORE="${CONFIG_VALUES_DIR}/vars-store/tas-vars"
  mkdir -p "${CONFIG_VALUES_DIR}/vars-store/"
  # Make sure bosh binary exists
  bosh --version >/dev/null

  ARGS=""
  if [[ -e ${CONFIG_VALUES_DIR}/_generated-values.yml ]]; then
    ARGS='--file-mark _generated-values.yml:exclude=true'
  fi

  bosh interpolate --vars-store=${VARS_STORE} <(ytt -f "${REPO_DIR}/config/_values.yml" --data-values-env YTT_TAS -f ${CONFIG_VALUES_DIR} $ARGS -f bosh_deployment.yml=<(cat <<EOF
#@ load("@ytt:data", "data")
#@ load("@ytt:assert", "assert")

variables:
- name: generated_kpack_webhook_server_tls
  type: certificate
  options:
    is_ca: true
    common_name: ca
- name: generated_kpack_webhook_server_tls_cert
  type: certificate
  options:
    ca: generated_kpack_webhook_server_tls
    common_name: "webhook-server.build-service.svc"
    alternative_names:
    - "webhook-server.build-service.svc.cluster.local"
    - "webhook-server.build-service.svc"
    - "webhook-server"
    - "webhook-server.build-service"
- name: generated_inject_ca_certs_into_running_apps_tls
  type: certificate
  options:
    is_ca: true
    common_name: ca
- name: generated_inject_ca_certs_into_running_apps_tls_cert
  type: certificate
  options:
    ca: generated_inject_ca_certs_into_running_apps_tls
    common_name: "ca-apps-injector.tas-system.svc"
    alternative_names:
    - "ca-apps-injector.tas-system.svc.cluster.local"
    - "ca-apps-injector.tas-system.svc"
    - "ca-apps-injector"
    - "ca-apps-injector.tas-system"
#! Usage Service
- name: generated_usage_service_cf_password
  type: password
- name: generated_usage_service_uaa_client_secret
  type: password
- name: generated_usage_service_secret_key_base
  type: password
#! Apps Manager
- name: generated_invitations_uaa_client_secret
  type: password
#! CF 4 K8s
- name: generated_blobstore_secret_key
  type: password
- name: generated_capi_db_encryption_key
  type: password
- name: generated_uaa_login_secret
  type: password
- name: generated_uaa_admin_client_secret
  type: password
- name: generated_uaa_encryption_key_passphrase
  type: password
- name: generated_cc_username_lookup_client_secret
  type: password
- name: generated_cf_api_controllers_client_secret
  type: password
- name: generated_default_ca
  type: certificate
  options:
    is_ca: true
    common_name: ca
- name: generated_internal_certificate
  type: certificate
  options:
    ca: generated_default_ca
    common_name: "*.cf-system.svc.cluster.local"
    alternative_names:
    - "*.cf-system.svc.cluster.local"
    extended_key_usage:
    - client_auth
    - server_auth

- name: generated_uaa_jwt_policy_signing_key
  type: certificate
  options:
    ca: generated_default_ca
    common_name: uaa_jwt_policy_signing_key

- name: generated_uaa_login_service_provider
  type: certificate
  options:
    ca: generated_default_ca
    common_name: uaa_login_service_provider

EOF
)) >/dev/null


YTT_OUTPUT=$(ytt --data-values-env YTT_TAS -f "${REPO_DIR}/config/_values.yml" -f values.yml=<(printf "#@data/values\n#@overlay/match-child-defaults missing_ok=True\n---\n";cat ${VARS_STORE}) -f ${CONFIG_VALUES_DIR} -f values_template.yml=<(cat <<EOF
#@ load("@ytt:base64", "base64")
#@ load("@ytt:data", "data")
#@ load("@ytt:assert", "assert")
---
#@ if not data.values.kpack_webhook_server_tls.crt:
kpack_webhook_server_tls:
  crt: #@ data.values.generated_kpack_webhook_server_tls_cert.certificate
  key: #@ data.values.generated_kpack_webhook_server_tls_cert.private_key
  ca: #@ data.values.generated_kpack_webhook_server_tls_cert.ca
#@ end
#@ if not data.values.inject_ca_certs_into_running_apps_tls.crt:
inject_ca_certs_into_running_apps_tls:
  crt: #@ data.values.generated_inject_ca_certs_into_running_apps_tls_cert.certificate
  key: #@ data.values.generated_inject_ca_certs_into_running_apps_tls_cert.private_key
  ca: #@ data.values.generated_inject_ca_certs_into_running_apps_tls_cert.ca
#@ end
usage_service:
#@ if not data.values.usage_service.cf_password:
  cf_password: #@ data.values.generated_usage_service_cf_password
#@ end
#@ if not data.values.usage_service.uaa_client_secret:
  uaa_client_secret: #@ data.values.generated_usage_service_uaa_client_secret
#@ end
#@ if not data.values.usage_service.secret_key_base:
  secret_key_base: #@ data.values.generated_usage_service_secret_key_base
#@ end
#@ if not data.values.apps_manager.invitations_uaa_client_secret:
apps_manager:
  invitations_uaa_client_secret: #@ data.values.generated_invitations_uaa_client_secret
#@ end

#@ if not data.values.blobstore.secret_access_key:
blobstore:
  secret_access_key: #@ data.values.generated_blobstore_secret_key
#@ end

capi:
#@ if not data.values.capi.cc_username_lookup_client_secret:
  cc_username_lookup_client_secret: #@ data.values.generated_cc_username_lookup_client_secret
#@ end
#@ if not data.values.capi.cf_api_controllers_client_secret:
  cf_api_controllers_client_secret: #@ data.values.generated_cf_api_controllers_client_secret
#@ end
  database:
#@ if not data.values.capi.database.encryption_key:
    encryption_key: #@ data.values.generated_capi_db_encryption_key
#@ end

#@ if not data.values.internal_certificate.crt:
internal_certificate:
  #! This certificates and keys should be valid for *.cf-system.svc.cluster.local
  crt: #@ data.values.generated_internal_certificate.certificate
  key: #@ data.values.generated_internal_certificate.private_key
  ca: #@ data.values.generated_internal_certificate.ca
#@ end

uaa:
#@ if not data.values.uaa.admin_client_secret:
  admin_client_secret: #@ data.values.generated_uaa_admin_client_secret
#@ end
#@ if not data.values.uaa.jwt_policy.signing_key:
  jwt_policy:
    signing_key: #@ data.values.generated_uaa_jwt_policy_signing_key.private_key
#@ end
#@ if not data.values.uaa.encryption_key.passphrase:
  encryption_key:
    passphrase: #@ data.values.generated_uaa_encryption_key_passphrase
#@ end
#@ if not data.values.uaa.login.service_provider.certificate:
  login:
    service_provider:
      key: #@ data.values.generated_uaa_login_service_provider.private_key
      certificate: #@ data.values.generated_uaa_login_service_provider.certificate
#@ end
#@ if not data.values.uaa.login_secret:
  login_secret: #@ data.values.generated_uaa_login_secret
#@ end
EOF
) ${ARGS})

echo -e "#@data/values\n---\n${YTT_OUTPUT}" > "${CONFIG_VALUES_DIR}/_generated-values.yml"

}

main "$@"
