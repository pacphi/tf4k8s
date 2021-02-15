accessKey:
  password: ${accesskey_password}
secretKey:
  password: ${secretkey_password}

ingress:
  enabled: true
  certManager: true
  annotations:
    kubernetes.io/ingress.class: nginx
    ingress.kubernetes.io/force-ssl-redirect: "true"
    kubernetes.io/ingress.allow-http: "false"
    nginx.ingress.kubernetes.io/whitelist-source-range: 0.0.0.0/0
  hosts:
    - name: ${minio_domain}
      path: /
      tls: true
      tlsSecret: minio-tls-secret
persistence:
  size: 100Gi
