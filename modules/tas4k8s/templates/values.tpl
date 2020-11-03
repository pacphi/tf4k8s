#@data/values
---
system_domain: "${system_domain}"
app_domains:
#@overlay/append
- "${app_domain}"

#! The password for the CF "admin" user.
#! - operators can use the admin user to test `cf push`
cf_admin_password: ${cf_admin_password}

system_certificate:
  #! These certificates and keys are base64 encoded and should be valid for *.system.cf.example.com
  crt: ${system_fullchain_certificate}
  key: ${system_private_key}
  ca: ""
workloads_certificate:
  #! These certificates and keys are base64 encoded and should be valid for *.apps.cf.example.com
  crt: ${workloads_fullchain_certificate}
  key: ${workloads_private_key}
  ca: ""

app_registry:
  hostname: ${registry_domain}
  repository_prefix: ${repository_prefix}
  username: ${registry_username}
  password: ${registry_password}
  ca: ""

system_registry:
  hostname: "${pivnet_registry_hostname}"
  username: "${pivnet_username}"
  password: "${pivnet_password}"

capi:
  database:
    host: "${postgres_instance_name}-postgresql.${postgres_instance_namespace}.svc.cluster.local"
    user: postgres
    password: ${postgres_password}
    name: cloud_controller
    ca_cert: ""
uaa:
  database:
    host: "${postgres_instance_name}-postgresql.${postgres_instance_namespace}.svc.cluster.local"
    user: postgres
    password: ${postgres_password}
    name: uaa
    ca_cert: ""
usage_service:
  database:
    host: "${postgres_instance_name}-postgresql.${postgres_instance_namespace}.svc.cluster.local"
    user: postgres
    password: ${postgres_password}
    name: usage_service
    ca_cert: ""

ingress:
  load_balancer:
    enable: ${enable_load_balancer}
