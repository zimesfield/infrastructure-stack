

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


  values = [
    yamlencode({
      architecture = "standalone"
      auth = {
        rootPassword = var.root_password
        username     = var.database_username
        password     = var.database_password
        database     = var.database_name
      }
      persistence = {
        enabled = true
        size    = var.persistent_size
        storageClass = kubernetes_storage_class.mongo_retain.metadata[0].name
      }

      rbac = { create = true }
    })
  ]
}