resource "helm_release" "mysql" {
  name       = var.app_name
  namespace  = var.namespace
  chart      = var.chart
  repository = "https://charts.bitnami.com/bitnami"  # Bitnami's chart repo
  version    = var.app_version  # use a version with externalAccess support

  # Set custom authentication values
  set_sensitive {
    name  = "auth.rootPassword"
    value = var.root_password      # <-- custom root password
  }
  set_sensitive {
    name  = "auth.username"
    value = var.database_username                 # <-- custom MySQL user
  }
  set_sensitive {
    name  = "auth.password"
    value = var.database_password         # <-- custom MySQL user password
  }
  set {
    name  = "auth.database"
    value = var.database_name            # <-- custom database name
  }

  values = [
    yamlencode({
      primary = {
        persistence = {
          enabled      = true
          size         = var.persistent_size
          storageClass = kubernetes_storage_class.mysql_retain.metadata[0].name
        }
        service = {
          type = "NodePort"
          nodePorts = {
            mysql = var.service_port
          }
        }
      }
    })
  ]
}



