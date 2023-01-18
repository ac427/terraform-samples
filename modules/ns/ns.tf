resource "kubernetes_namespace" "name_space" {
  metadata {
    labels = {
      team = var.name
    }
    name = var.name
  }
}
