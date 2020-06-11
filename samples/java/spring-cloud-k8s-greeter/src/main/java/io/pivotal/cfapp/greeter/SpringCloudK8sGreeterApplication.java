package io.pivotal.cfapp.greeter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.cloud.context.scope.refresh.RefreshScope;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import reactor.core.publisher.Mono;
@SpringBootApplication
@ConfigurationPropertiesScan
public class SpringCloudK8sGreeterApplication {

	public static void main(String[] args) {
		SpringApplication.run(SpringCloudK8sGreeterApplication.class, args);
	}

	@RefreshScope
	@Configuration
	@ConfigurationProperties(prefix = "dialog")
	public class DialogConfig {

		private String greeting;
		private String farewell;

		public String getGreeting() {
			return this.greeting;
		}

		public String getFarewell() {
			return this.farewell;
		}

		public void setGreeting(String greeting) {
			this.greeting = greeting;
		}

		public void setFarewell(String farewell) {
			this.farewell = farewell;
		}

	}

	@RestController
	public class DialogController {

		private final DialogConfig config;

		@Autowired
		public DialogController(
			DialogConfig config) {
			this.config = config;
		}

		@GetMapping("/greeting")
		public Mono<ResponseEntity<String>> sayGreeting() {
			return Mono
					.justOrEmpty(config.getGreeting())
					.map(greeting -> ResponseEntity.ok(greeting));
		}

		@GetMapping("/farewell")
		public Mono<ResponseEntity<String>> sayFarewell() {
			return Mono
					.justOrEmpty(config.getFarewell())
					.map(farewell -> ResponseEntity.ok(farewell));
		}
	}
}
