imageCredentialsForTSMGRImages:
  registry: ${tsmgr_images_registry}
  username: ${registry_username}
  password: ${registry_password}

imageCredentialsForServiceInstances:
  registry: ${si_images_registry}
  username: ${registry_username}
  password: ${registry_password}

broker:
  image:
    repository: ${tsmgr_images_registry}/broker
  password: ${broker_password}

daemon:
  image:
    repository: ${tsmgr_images_registry}/daemon
  password: ${daemon_password}

ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: "contour"
    ingress.kubernetes.io/force-ssl-redirect: "true"
    kubernetes.io/ingress.allow-http: "false"
    kubernetes.io/tls-acme: "true"
    cert-manager.io/issuer: "letsencrypt-prod"
  hosts:
    - ${tsmgr_domain}
  tls:
    - secretName: tsmgr-tls-secret
      hosts:
        - ${daemon_domain}
    - secretName: tsmgr-tls-secret
      hosts:
        - ${broker_domain}

chartmuseum:
  image:
    repository: ${tsmgr_images_registry}/chartmuseum
  env:
    open:
      STORAGE_AMAZON_BUCKET: ${s3_bucket_name}
      STORAGE_AMAZON_ENDPOINT: https://${s3_endpoint}
      BASIC_AUTH_PASS: ${chartmuseum_password}
    secret:
      AWS_ACCESS_KEY_ID: ${s3_access_key}
      AWS_SECRET_ACCESS_KEY:  ${s3_secret_key}
  resources:
    limits:
      cpu: 100m
      memory: 128Mi
    requests:
      cpu: 80m
      memory: 64Mi

resources:
  limits:
    cpu: 100m
    memory: 256Mi
  requests:
    cpu: 100m
    memory: 256Mi

cf:
 apiAddress: https://${cf_api_endpoint}
 username: ${cf_admin_username}
 password: ${cf_admin_password}
 brokerName: tsmgr
 brokerUrl: https://${broker_domain}