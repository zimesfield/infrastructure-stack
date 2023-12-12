resource "helm_release" "postgresql_helm_release" {
  name             = var.app_name
  namespace        = var.namespace_name
  chart            = var.chart_name
  repository       = "https://charts.bitnami.com/bitnami"
  create_namespace = true
  version          = var.app_version# You can specify the version you want

  set {
    name = "primary.persistence.mountPath"
    value = "/bitnami/keycloak/postgres"
  }

  set {
    name  = "auth.username"
    value = var.db_username# Change this to a strong password
  }

  set_sensitive {
    name  = "auth.password"
    value = var.db_password # Change this to a strong password
  }

  set {
    name  = "auth.database"
    value = var.db_name  # PostgreSQL database name
  }
}

