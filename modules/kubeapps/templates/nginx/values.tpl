useHelm3: true

ingress:
  enabled: true
  certManager: true
  hostname: ${kubeapps_domain}
  tls: true
  annotations:
    kubernetes.io/ingress.class: nginx
    kubernetes.io/tls-acme: "true"

secrets:
  - name: kubeapps-tls-secret
