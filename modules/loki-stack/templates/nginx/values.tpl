admin:
  password: ${admin_password}
ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: nginx
    ingress.kubernetes.io/force-ssl-redirect: "true"
    kubernetes.io/ingress.allow-http: "false"
    kubernetes.io/tls-acme: "true"
  hosts:
    - name: ${grafana_domain}
      tls: true
      tlsSecret: grafana-tls-secret
