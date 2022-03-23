provider "kubernetes" {
  config_context_cluster   = "minikube"
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

resource "kubernetes_namespace" "lab1" {
  metadata {

    labels = {
      app = "nginx"
    }

    name = "lab1"
  }
}


resource "kubernetes_pod" "nginx" {
  metadata {
    name = "nginx"
    namespace = "lab1"

  }

  spec {
    container {
      image = "nginx"
      name  = "nginx"

      env {
        name  = "secret"
        value = "top-secret"
      }

      port {
        container_port = 80
      }

      liveness_probe {
        http_get {
          path = "/"
          port = 80

          http_header {
            name  = "X-Custom-Header"
            value = "Awesome"
          }
        }

        initial_delay_seconds = 3
        period_seconds        = 3
      }
    }

    dns_config {
      nameservers = ["1.1.1.1", "8.8.8.8", "9.9.9.9"]
      searches    = ["example.com"]

      option {
        name  = "ndots"
        value = 1
      }

      option {
        name = "use-vc"
      }
    }

    dns_policy = "None"
  }
}

output "spec" {
  description = "returns a list of object"
  value = kubernetes_pod.nginx.spec[0]
}
