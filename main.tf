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
