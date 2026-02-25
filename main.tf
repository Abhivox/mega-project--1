provider "kubernetes" {
  config_path = "~/.kube/config"
}
resource "kubernetes_namespace" "mega_ns" {
  metadata {
    name = "megaproject"
  }
}

