apiVersion: jenkins.io/v1alpha2
kind: Jenkins
metadata:
  name: ${instance_name}
spec:
  master:
    containers:
    - name: jenkins-master
      image: jenkins/jenkins:lts
      imagePullPolicy: Always
      livenessProbe:
        failureThreshold: 12
        httpGet:
          path: /login
          port: http
          scheme: HTTP
        initialDelaySeconds: 80
        periodSeconds: 10
        successThreshold: 1
        timeoutSeconds: 5
      readinessProbe:
        failureThreshold: 3
        httpGet:
          path: /login
          port: http
          scheme: HTTP
        initialDelaySeconds: 30
        periodSeconds: 10
        successThreshold: 1
        timeoutSeconds: 1
      resources:
        limits:
          cpu: 1500m
          memory: 3Gi
        requests:
          cpu: "1"
          memory: 500Mi
      securityContext:
        runAsUser: 1000
        fsGroup: 1000
  # seedJobs:
  # - id: jenkins-operator
  #   targets: "cicd/jobs/*.jenkins"
  #   description: "Jenkins Operator Example Repository"
  #   repositoryBranch: jenkins_operator
  #   repositoryUrl: https://github.com/pavan-kumar-99/medium-manifests.git