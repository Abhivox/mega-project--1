provider "kubernetes" {
  config_path = "~/.kube/config"
}
resource "kubernetes_namespace" "flask_ns" {
  metadata {
    name = "flask-app"
  }
}
