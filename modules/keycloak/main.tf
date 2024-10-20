resource "helm_release" "keycloak" {
  name             = var.app_name  # Name of the Helm release
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "keycloak"  # Name of the Helm chart
  namespace        = var.namespace  # Namespace where Keycloak will be deployed
  version          = var.app_version

  set {
    name  = "proxyAddressForwarding"
    value = "true"
  }

  set {
    name  = "containerPorts.http"
    value = "9080"
  }

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
    value = "keycloak-db-postgresql"
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
    value = "keycloak-db-postgresql"
  }

  set {
    name  = "externalDatabase.existingSecretPasswordKey"
    value = "password"
  }

  set {
    name  = "externalDatabase.user"
    value = var.db_username
  }

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  set {
    name  = "readinessProbe.enabled"
    value = false
  }

  set {
    name  = "readinessProbe.initialDelaySeconds"
    value = 60
  }

  set {
    name  = "readinessProbe.failureThreshold"
    value = 6
  }
}

data "kubernetes_service" "postgresql" {
  metadata {
    name      = "${var.app_name}-postgresql"
    namespace = var.namespace
  }
}

# resource "kubernetes_ingress" "keycloak_ingress" {
#   metadata {
#     name = "${var.namespace}-ingress"
#     annotations = {
#       "nginx.ingress.kubernetes.io/rewrite-target" = "/"
#     }
#     namespace = var.namespace
#   }
#   spec {
#     rule {
#       host = "keycloak.zimesfield.com"  # Replace with your domain
#       http {
#         path {
#           backend {
#             service_name = helm_release.keycloak_helm_release.metadata[0].name
#             service_port = var.db_port
#           }
#         }
#       }
#     }
#   }
# }
#
#
#
