terraform {
  required_version = "~> 1.2.9"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 3.11.0"
    }
    kubernetes = {
      version = "~> 2.16.0"
    }
  }
}

provider "kubernetes" {
  config_context_cluster = "minikube"
  config_path            = "~/.kube/config"
  config_context         = "minikube"
}
