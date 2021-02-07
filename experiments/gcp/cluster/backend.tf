terraform {
  backend "artifactory" {
    username = "admin"
    password = "ajesnty7nKXzLrbR"
    url      = "https://krups.ironleg.me/artifactory"
    repo     = "terraform-state"
    subpath  = "tf4k8s/experiments/gcp/cluster"
  }
}
