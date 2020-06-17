ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: "contour"
    ingress.kubernetes.io/force-ssl-redirect: "true"
    kubernetes.io/ingress.allow-http: "false"
    kubernetes.io/tls-acme: "true"
  path: /
  hosts:
    - ${kibana_domain}
  tls:
    - secretName: kibana-tls-secret
      hosts:
        - ${kibana_domain}
