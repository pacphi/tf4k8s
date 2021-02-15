## ArgoCD configuration (overrides)
## Ref: https://github.com/argoproj/argo-cd
## @see https://hub.helm.sh/charts/argo/argo-cd

global:
  image:
    repository: argoproj/argocd
    tag: ${argocd_version}

controller:
  name: application-controller

  image:
    repository: argoproj/argocd
    tag: ${argocd_version}

dex:
  enabled: true
  name: dex-server

  image:
    repository: quay.io/dexidp/dex
    tag: v2.25.0
 
redis:
  enabled: true
  name: redis

  image:
    repository: redis
    tag: 6.0.8
 
server:
  name: server

  image:
    repository: argoproj/argocd
    tag: ${argocd_version}
    
  certificate:
    enabled: true
    domain: ${argocd_domain}
    issuer:
      name: letsencrypt-prod

  ingress:
    enabled: true
    annotations:
      cert-manager.io/cluster-issuer: letsencrypt-prod
      kubernetes.io/ingress.class: nginx
      kubernetes.io/tls-acme: "true"
      nginx.ingress.kubernetes.io/ssl-passthrough: "true"
      nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"

    hosts:
      - ${argocd_domain}
    paths:
      - /
    tls:
      - hosts:
        - ${argocd_domain}
        secretName: argocd-secret

  config:
    url: https://${argocd_domain}
    
  
repoServer:
  name: repo-server
  image:
    repository: argoproj/argocd
    tag: ${argocd_version}
