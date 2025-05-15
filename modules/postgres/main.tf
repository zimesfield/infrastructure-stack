resource "helm_release" "postgresql" {
  name       = var.app_name
  namespace  = var.namespace
  chart      = var.chart
  repository = "https://charts.bitnami.com/bitnami"
  version    = var.app_version

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
      auth = {
        postgresPassword = var.root_password
        username         = var.database_name
        password         = var.database_password
        database         = var.database_name
      }
    })
  ]

}


