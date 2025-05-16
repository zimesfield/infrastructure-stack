

resource "helm_release" "mongodb" {
  name       = var.app_name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "mongodb"
  version    = var.app_version  # use a version with externalAccess support
  namespace  = var.namespace

  set {
    name  = "service.type"
    value = "NodePort"
  }
  set {
    name  = "service.nodePorts.mongodb"
    value = var.service_port
  }


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
    name  = "auth.rootPassword"
    value = var.root_password
  }

  set_sensitive {
    name  = "auth.username"
    value = var.database_username
  }


  values = [
    yamlencode({
      architecture = "standalone"
      persistence = {
        enabled = true
        size    = var.persistent_size
        storageClass = kubernetes_storage_class.mongo_retain.metadata[0].name
      }

      rbac = { create = true }
    })
  ]
}