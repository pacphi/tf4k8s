artifactory:
  ingress:
    enabled: true
    hosts:
      - ${jcr_domain}
    annotations:
      kubernetes.io/ingress.class: "nginx"
      nginx.ingress.kubernetes.io/enable-cors: "true"
      nginx.ingress.kubernetes.io/proxy-body-size: "0"
      ingress.kubernetes.io/force-ssl-redirect: "true"
      ingress.kubernetes.io/proxy-body-size: "0"
      ingress.kubernetes.io/proxy-read-timeout: "600"
      ingress.kubernetes.io/proxy-send-timeout: "600"
      kubernetes.io/ingress.allow-http: "false"
    tls:
      - secretName: jcr-tls-secret
        hosts:
          - ${jcr_domain}
  nginx:
    enabled: false
  service:
    type: "NodePort"

postgresql:
  postgresqlPassword: ${jcr_postgresql_password}
