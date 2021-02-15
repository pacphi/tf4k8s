apiVersion: pksapi.io/v1beta1
kind: ClusterLogSink
metadata:
   name: ${name}
spec:
   type: syslog
   host: ${host}
   port: ${port}
   enable_tls: true
   insecure_skip_verify: ${insecure_skip_verify}