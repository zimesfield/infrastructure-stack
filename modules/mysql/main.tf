resource "helm_release" "mysql" {
  name      = var.app_name
  namespace = var.namespace
  chart   = "oci://registry-1.docker.io/bitnamicharts/mysql"
  version = var.app_version

  # Enable replication mode
  set {
    name  = "architecture"
    value = "standalone"
  }

  # One primary and one secondary
  set {
    name  = "replicaCount"
    value = "1"
  }

  # Root and application credentials
  set_sensitive {
    name  = "auth.rootPassword"
    value = var.root_password
  }
  set {
    name  = "auth.username"
    value = var.database_username
  }
  set_sensitive {
    name  = "auth.password"
    value = var.database_password
  }
  set {
    name  = "auth.database"
    value = var.database_name
  }

#   # Replication user credentials
#   set {
#     name  = "auth.replicationUser"
#     value = var.database_username
#   }
#   set_sensitive {
#     name  = "auth.replicationPassword"
#     value = var.database_password
#   }

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


