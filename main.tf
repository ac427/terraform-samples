resource "kubernetes_namespace" "engineering" {
  metadata {
    labels = {
      team = "engineering"
    }
    name = "engineering"
  }
}

resource "kubernetes_config_map" "sample_cm" {
  metadata {
    labels = {
      team = "sample_cm"
    }
    name      = "sample-cm"
    namespace = "engineering"
  }
  data = {
    api_host             = "myhost:443"
    db_host              = "dbhost:5432"
    "my_config_file.yml" = file("${path.module}/files/my_config_file.yml")
  }

  #  binary_data = {
  #    "hello-world.bin" = filebase64("${path.module}/files/hello-world.bin")
  #  }
}

# local variables
locals {
  ns = ["finance", "hr"]
}

# https://developer.hashicorp.com/terraform/language/modules
# In the below example. We are iteration over local variable and creating namespaces
# modules help in reusing the code. We just avoided writing kubernetes_namespace block twice in below example

module "name_space" {
  for_each = toset(local.ns)
  name     = each.value
  source   = "./modules/ns"
}


resource "kubernetes_secret" "example" {
  metadata {
    name = "sample-cfg"
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.registry_server}" = {
          "username" = var.registry_username
          "password" = var.registry_password
          "email"    = var.registry_email
          "auth"     = base64encode("${var.registry_username}:${var.registry_password}")
        }
      }
    })
  }
}


# data block; https://developer.hashicorp.com/terraform/language/data-sources
# Example; lets say engineering ns is created outside TF. We can extract the info with below example and re-use in different resource or just stdout as output

data "kubernetes_namespace" "engineering" {
  metadata {
    name = "engineering"
  }
}

# you can view the output when we run apply, even when there is no change in plan
output "data" {
  value = data.kubernetes_namespace.engineering
}
