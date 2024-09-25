resource "helm_release" "postgresql" {
  name             = var.app_name
  namespace        = var.namespace_name
  chart            = var.chart_name
  repository       = "https://charts.bitnami.com/bitnami"
  create_namespace = true
  version          = var.app_version

  set {
    name = "primary.persistence.mountPath"
    value = "/bitnami/postgres"
  }

  set {
    name  = "auth.username"
    value = var.db_username
  }

  set_sensitive {
    name  = "auth.password"
    value = var.db_password
  }

  set {
    name  = "auth.database"
    value = var.db_name
  }
}

