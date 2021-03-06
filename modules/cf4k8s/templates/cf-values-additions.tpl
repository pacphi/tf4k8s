#! The password for the CF "admin" user.
#! - operators can use the admin user to test `cf push`
cf_admin_password: ${cf_admin_password}

#! To push apps from source code, you need to configure the `app_registry` block
#! Example below is for docker hub. For other registry examples, see below.

app_registry:
  hostname: ${registry_domain}
  #! often times this is just your `docker_user`
  repository_prefix: ${repository_prefix}
  username: ${registry_username}
  password: ${registry_password}

gateway:
  https_only: ${https_only}

remove_resource_requirements: ${remove_resource_requirements}
add_metrics_server_components: ${add_metrics_server_components}
allow_prometheus_metrics_access: ${allow_prometheus_metrics_access}
use_external_dns_for_wildcard: ${use_external_dns_for_wildcard}
enable_automount_service_account_token: ${enable_automount_service_account_token}
metrics_server_prefer_internal_kubelet_address: ${metrics_server_prefer_internal_kubelet_address}
use_first_party_jwt_tokens: ${use_first_party_jwt_tokens}

load_balancer:
  enable: ${enable_load_balancer}
