#@data/values
---
system_domain: "${system_domain}"
app_domains:
#@overlay/append
- "${app_domain}"

#! The password for the CF "admin" user.
#! - operators can use the admin user to test `cf push`
cf_admin_password: ${cf_admin_password}

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
  external_traffic_policy: "Local"

use_first_party_jwt: ${use_first_party_jwt}
