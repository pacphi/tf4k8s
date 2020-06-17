ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: nginx
    kubernetes.io/tls-acme: "true"
  path: /
  hosts:
    - ${kibana_domain}
  tls:
    - secretName: kibana-tls-secret
      hosts:
        - ${kibana_domain}
