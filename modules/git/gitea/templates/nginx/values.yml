config:
  requireSignin: true

ingress:
  enabled: true
  useSSL: true

  ingress_annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/proxy-body-size: "0"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "600"
    nginx.ingress.kubernetes.io/proxy-send-timeout: "600"
    nginx.ingress.kubernetes.io/auth-secret: basic-auth
    nginx.ingress.kubernetes.io/auth-realm: "Authentication Required - lab"
    ingress.kubernetes.io/force-ssl-redirect: "true"
    kubernetes.io/ingress.allow-http: "false"

  tls:
    - secretName: gitea-tls-secret
      hosts:
        - ${gitea_domain}

service:
  http:
    serviceType: ClusterIP
    port: 3000
    externalPort: 443
    externalHost: ${gitea_domain}
  ssh:
    serviceType: NodePort
    port: 22
    nodePort: 30222
    externalPort: 22
    externalHost: ${gitea_domain}

persistence:
  enabled: ${persistence_enabled}
  giteaSize: 20Gi
  postgresSize: 10Gi
  storageClass: ${persistence_storageclass}
  accessMode: ReadWriteMany
  annotations:
    "helm.sh/resource-policy": keep

inPodPostgres:
  secret: ${inpod_postgres_secret}