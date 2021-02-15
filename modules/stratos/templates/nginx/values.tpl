console:
  sessionStoreSecret: ${session_store_secret}
  service:
    type: LoadBalancer
    ingress:
      ## If true, Ingress will be created
      enabled: true

      ## Additional annotations
      annotations:
        kubernetes.io/ingress.class: "nginx"
        nginx.ingress.kubernetes.io/enable-cors: "true"
        ingress.kubernetes.io/force-ssl-redirect: "true"
        kubernetes.io/ingress.allow-http: "false"

      ## Host for the ingress
      # Defaults to console.[env.Domain] if env.Domain is set and host is not
      host: ${stratos_domain}

      # Name of secret containing TLS certificate
      secretName: stratos-tls-secret
