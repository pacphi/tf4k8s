web:
  ingress:
    enabled: true
    annotations:
      kubernetes.io/ingress.class: contour
      ingress.kubernetes.io/force-ssl-redirect: "true"
      kubernetes.io/ingress.allow-http: "false"
      kubernetes.io/tls-acme: "true"
    hosts:
      - ${concourse_domain}
    tls:
      - secretName: concourse-web-tls
        hosts:
          - ${concourse_domain}
  prometheus:
    enabled: true
persistence:
  worker:
    size: 50Gi
secrets:
  localUsers: ${concourse_username}:${concourse_password}

concourse:
  web:
    externalUrl: https://${concourse_domain}
    auth:
      mainTeam:
        localUser: "${concourse_username}"
