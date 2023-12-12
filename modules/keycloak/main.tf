resource "helm_release" "keycloak_helm_release" {
  name             = var.app_name  # Name of the Helm release
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = var.chart_name  # Name of the Helm chart
  namespace        = var.namespace  # Namespace where Keycloak will be deployed
  version          = var.app_version
  create_namespace = true
  set {
    name  = "postgresql.enabled"
    value = "false"
  }

  set {
    name  = "auth.adminUser"
    value = var.username
  }

  set_sensitive {
    name  = "auth.adminPassword"
    value = var.password
  }

  set {
    name  = "externalDatabase.host"
    value = var.db_host
  }

  set {
    name  = "externalDatabase.port"
    value = var.db_port
  }

  set {
    name  = "externalDatabase.database"
    value = var.db_name
  }

  set {
    name  = "externalDatabase.existingSecret"
    value = var.db_password_secret
  }

  set {
    name  = "externalDatabase.existingSecretPasswordKey"
    value = var.db_password_key
  }

  set {
    name  = "externalDatabase.user"
    value = var.db_username
  }
}


resource "kubernetes_ingress" "keycloak_ingress" {
  metadata {
    name = "${var.namespace}-ingress"
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
    namespace = var.namespace
  }
  spec {
    rule {
      host = "keycloak.zimesfield.com"  # Replace with your domain
      http {
        path {
          backend {
            service_name = helm_release.keycloak-server.metadata[0].name
            service_port = var.db_port
          }
        }
      }
    }
  }
}



