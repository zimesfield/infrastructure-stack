resource "helm_release" "elasticsearch" {
  name       = var.app_name  # Name of the Helm release
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "elasticsearch"
  namespace = var.namespace
   version    = var.app_version

  values = [
    file("${path.module}/values.yaml")
  ]
}
