# You provide versions. More about version constraints https://developer.hashicorp.com/terraform/language/expressions/version-constraints

terraform {
  required_version = "~> 1.2.9"
  # we don't use newrelic provider in the code. This is just for example
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

# provider config. 
provider "kubernetes" {
  config_context_cluster = "minikube"
  config_path            = "~/.kube/config"
  config_context         = "minikube"
}

#provider "newrelic" {
#  account_id = var.newrelic_account_id
#  api_key    = var.api_key
#}