provider "kubernetes" {
  config_path = "~/.kube/config"
}
resource "kubernetes_namespace" "mega_ns" {
  metadata {
    name = "megaproject"
  }
}
resource "kubernetes_deployment" "mega_project" {
  metadata {
    name      = "megaproject1"
    namespace = kubernetes_namespace.mega_ns.metadata[0].name
    labels = {
      app = "megaproject1"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "megaproject1"
      }
    }

    template {
      metadata {
        labels = {
          app = "megaproject1"
        }
      }

      spec {
        container {
          image = "abhi13055/megaproject1"
          name  = "megaproject1"

          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "mega_service" {
  metadata {
    name      = "megaproject1"
    namespace = kubernetes_namespace.mega_ns.metadata[0].name
  }

  spec {
    selector = {
      app = "megaproject1"
    }

    port {
      port        = 80
      target_port = 5000
      node_port   = 30007
    }

    type = "NodePort"
  }
}



