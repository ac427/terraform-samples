# https://developer.hashicorp.com/terraform/language/values/variables

variable "nginx_img" {
  type        = string
  default     = "bitnami/nginx"
  description = "default nginx image"
}

variable "registry_username" {
  default = "foo"
}

#secret; export env TF_VAR_registry_password during execution or TF will prompt during execution
variable "registry_password" {}

variable "registry_email" {
  default = "foo@foo.com"
}

variable "registry_server" {
  default = "https://foo.com"
}

#variable "newrelic_account_id" {
#  default = "1234"
#}

# variable "newrelic_api" {}