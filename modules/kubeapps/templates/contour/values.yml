useHelm3: true

ingress:
  enabled: true
  certManager: true
  hostname: ${kubeapps_domain}
  tls: true
  annotations:
    kubernetes.io/ingress.class: "contour"
    ingress.kubernetes.io/force-ssl-redirect: "true"
    kubernetes.io/ingress.allow-http: "false"
    kubernetes.io/tls-acme: "true"

secrets:
  - name: kubeapps-tls-secret
