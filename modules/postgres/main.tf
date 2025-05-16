resource "helm_release" "postgresql" {
  name       = var.app_name
  namespace  = var.namespace
  chart      = var.chart
  repository = "https://charts.bitnami.com/bitnami"
  version    = var.app_version

  set_sensitive {
    name  = "auth.username"
    value = var.database_username
  }

  set_sensitive {
    name  = "auth.database"
    value = var.database_name
  }

  set_sensitive {
    name  = "auth.password"
    value = var.database_password
  }

  set_sensitive {
    name  = "auth.postgresPassword"
    value = var.root_password
  }

  values = [
    yamlencode({
      primary = {
        persistence = {
          enabled      = true
          size         = var.persistent_size
          storageClass = kubernetes_storage_class.postgres_retain.metadata[0].name
        }
        service = {
          type = "NodePort"
          nodePorts = {
            postgresql = var.service_port
          }
        }
      }
    })
  ]

}


