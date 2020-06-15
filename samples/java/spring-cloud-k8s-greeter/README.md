# Spring Cloud Kubernetes sample

A simple micro-service that responds with a greeting and farewell.

Let's get this out of the way now.  If you attempt to deploy this to cf4k8s or tas4k8s it will **not** work.  That's because the underlying Kubernetes resources are sand-boxed.

## How to clone

```
git clone https://github.com/pacphi/tf4k8s
cd samples/java/spring-cloud-k8s-greeter
```

## How to build

### Prerequisites

* OpenJDK 11

```
./gradlew clean build
./gradlew bootBuildImage
```

## How to deploy

### to a native Kubernetes cluster/namespace

```
./create-resources.sh
```

// TODO

Basically riff of this [tutorial](https://docs.bitnami.com/tutorials/deploy-spring-boot-application-production-helm/) to create a Helm chart.  Make sure the image and that chart are published to Harbor.  Then use Argo CD to deploy.


### to demonstrate operating failure on cf4k8s/tas4k8s

```
./gradlew clean
./create-resources.sh
cf push greeter
```

Here's an example of the log output

```
2020-06-09T11:54:52.94-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT 2020-06-09 18:54:52.939  WARN 1 --- [           main] io.fabric8.kubernetes.client.Config      : Error reading service account token from: [/var/run/secrets/kubernetes.io/serviceaccount/token]. Ignoring.
2020-06-09T11:54:52.94-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT 2020-06-09 18:54:52.942  WARN 1 --- [           main] o.s.c.k.KubernetesAutoConfiguration      : No namespace has been detected. Please specify KUBERNETES_NAMESPACE env var, or use a later kubernetes version (1.3 or later)
   2020-06-09T11:54:53.10-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT 
   2020-06-09T11:54:53.10-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT .   ____          _            __ _ _
   2020-06-09T11:54:53.10-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
   2020-06-09T11:54:53.10-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT ( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
   2020-06-09T11:54:53.10-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
   2020-06-09T11:54:53.10-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT '  |____| .__|_| |_|_| |_\__, | / / / /
   2020-06-09T11:54:53.10-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT =========|_|==============|___/=/_/_/_/
   2020-06-09T11:54:53.11-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT :: Spring Boot ::        (v2.3.1.RELEASE)
   2020-06-09T11:54:53.11-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT 
   2020-06-09T11:54:53.28-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT {"start_time":"2020-06-09T18:54:53.211Z","method":"-","request_id":"-","upstream_host":"10.15.240.1:443","x_forwarded_for":"-","referer":"-","bytes_sent":"1439","response_duration":"-","upstream_cluster":"PassthroughCluster","x_b3_traceid":"-","downstream_remote_address":"10.12.5.23:38270","x_forwarded_proto":"-","authority":"-","path":"-","protocol":"-","upstream_service_time":"-","upstream_local_address":"10.12.5.23:38272","duration":"77","downstream_local_address":"10.15.240.1:443","upstream_transport_failure_reason":"-","response_code":"0","response_flags":"-","response_tx_duration":"-","requested_server_name":"-","bytes_received":"239","organization_id":"-","app_id":"-","x_b3_spanid":"-","process_type":"-","x_b3_parentspanid":"-","space_id":"-","user_agent":"-"}
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT 2020-06-09 18:54:53.296  WARN 1 --- [           main] o.s.c.k.config.ConfigMapPropertySource   : Can't read configMap with name: [greetings-config] in namespace:[bitter-tears]. Ignoring.
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT 
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT io.fabric8.kubernetes.client.KubernetesClientException: Operation: [get]  for kind: [ConfigMap]  with name: [greetings-config]  in namespace: [bitter-tears]  failed.
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT at io.fabric8.kubernetes.client.KubernetesClientException.launderThrowable(KubernetesClientException.java:64) ~[kubernetes-client-4.9.0.jar:na]
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT at io.fabric8.kubernetes.client.KubernetesClientException.launderThrowable(KubernetesClientException.java:72) ~[kubernetes-client-4.9.0.jar:na]
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT at io.fabric8.kubernetes.client.dsl.base.BaseOperation.getMandatory(BaseOperation.java:225) ~[kubernetes-client-4.9.0.jar:na]
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT at io.fabric8.kubernetes.client.dsl.base.BaseOperation.get(BaseOperation.java:168) ~[kubernetes-client-4.9.0.jar:na]
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT at org.springframework.cloud.kubernetes.config.ConfigMapPropertySource.getData(ConfigMapPropertySource.java:97) ~[spring-cloud-kubernetes-config-2.0.0-M2.jar:2.0.0-M2]
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT at org.springframework.cloud.kubernetes.config.ConfigMapPropertySource.<init>(ConfigMapPropertySource.java:78) ~[spring-cloud-kubernetes-config-2.0.0-M2.jar:2.0.0-M2]
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT at org.springframework.cloud.kubernetes.config.ConfigMapPropertySourceLocator.getMapPropertySourceForSingleConfigMap(ConfigMapPropertySourceLocator.java:96) ~[spring-cloud-kubernetes-config-2.0.0-M2.jar:2.0.0-M2]
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT at org.springframework.cloud.kubernetes.config.ConfigMapPropertySourceLocator.lambda$locate$0(ConfigMapPropertySourceLocator.java:79) ~[spring-cloud-kubernetes-config-2.0.0-M2.jar:2.0.0-M2]
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT at java.base/java.util.ArrayList.forEach(Unknown Source) ~[na:na]
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT at org.springframework.cloud.kubernetes.config.ConfigMapPropertySourceLocator.locate(ConfigMapPropertySourceLocator.java:78) ~[spring-cloud-kubernetes-config-2.0.0-M2.jar:2.0.0-M2]
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT at org.springframework.cloud.bootstrap.config.PropertySourceLocator.locateCollection(PropertySourceLocator.java:52) ~[spring-cloud-context-3.0.0-M2.jar:3.0.0-M2]
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT at org.springframework.cloud.bootstrap.config.PropertySourceLocator.locateCollection(PropertySourceLocator.java:47) ~[spring-cloud-context-3.0.0-M2.jar:3.0.0-M2]
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT at org.springframework.cloud.bootstrap.config.PropertySourceBootstrapConfiguration.initialize(PropertySourceBootstrapConfiguration.java:98) ~[spring-cloud-context-3.0.0-M2.jar:3.0.0-M2]
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT at org.springframework.boot.SpringApplication.applyInitializers(SpringApplication.java:626) ~[spring-boot-2.3.1.RELEASE.jar:2.3.1.RELEASE]
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT at org.springframework.boot.SpringApplication.prepareContext(SpringApplication.java:370) ~[spring-boot-2.3.1.RELEASE.jar:2.3.1.RELEASE]
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT at org.springframework.boot.SpringApplication.run(SpringApplication.java:314) ~[spring-boot-2.3.1.RELEASE.jar:2.3.1.RELEASE]
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT at org.springframework.boot.SpringApplication.run(SpringApplication.java:1237) ~[spring-boot-2.3.1.RELEASE.jar:2.3.1.RELEASE]
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT at org.springframework.boot.SpringApplication.run(SpringApplication.java:1226) ~[spring-boot-2.3.1.RELEASE.jar:2.3.1.RELEASE]
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT at io.pivotal.cfapp.greeter.SpringCloudK8sGreeterApplication.main(SpringCloudK8sGreeterApplication.java:20) ~[classes/:na]
   2020-06-09T11:54:53.29-0700 [APP/c4b80a05-c622-4eb3-8c4d-93621ba4e9ae] OUT Caused by: javax.net.ssl.SSLHandshakeException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target
```

## How to destroy

### having demonstrated operating failure on cf4k8s/tas4k8s

```
cf delete greeter -r -f
./destroy-resources.sh
```