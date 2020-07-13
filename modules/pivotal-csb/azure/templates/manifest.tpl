---
applications:
- name: cloud-service-broker
  command: cloud-service-broker serve
  memory: 1G
  docker:
    image: ${docker_image}
    username: ${docker_username}
  random-route: true
  env:
    GSB_BROKERPAK_BUILTIN_PATH: /azure-brokerpak
    ARM_SUBSCRIPTION_ID: ${az_subscription_id}
    ARM_TENANT_ID:  ${az_tenant_id}
    ARM_CLIENT_ID: ${az_client_id}
    ARM_CLIENT_SECRET: ${az_client_secret}
    DB_HOST: ${db_host}
    DB_NAME: ${db_name}
    DB_PORT: ${db_port}
    DB_USERNAME: ${db_user}
    DB_PASSWORD: ${db_password}
    CA_CERT: ${db_ca_cert}
    CLIENT_CERT: ${db_client_cert}
    CLIENT_KEY: ${db_client_key}
    SECURITY_USER_NAME: ${api_user}
    SECURITY_USER_PASSWORD: ${api_password}