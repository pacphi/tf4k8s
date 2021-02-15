externalURL: https://${harbor_domain}
harborAdminPassword: ${admin_password}
expose:
  tls:
    certSource: secret
    secret:
      secretName: harbor-tls-secret
      notarySecretName: harbor-tls-secret
  ingress:
    hosts:
      core: ${harbor_domain}
      notary: ${notary_domain}
    annotations:
      kubernetes.io/ingress.class: "contour"
      ingress.kubernetes.io/force-ssl-redirect: "true"
      kubernetes.io/ingress.allow-http: "false"
persistence:
  # Setting it to "keep" to avoid removing PVCs during a helm delete
  # operation. Leaving it empty will delete PVCs after the chart deleted
  resourcePolicy: ""
  persistentVolumeClaim:
    registry:
      size: 100Gi
    chartmuseum:
      size: 20Gi
    jobservice:
      size: 5Gi
    database:
      size: 5Gi
    redis:
      size: 2Gi
    trivy:
      size: 10Gi
