# resource "helm_release" "mongodb" {
#   name       = var.app_name
#   namespace  = var.namespace
#   repository = "https://charts.bitnami.com/bitnami"
#   chart      = "mongodb"
#   version    = var.app_version
#
#   set {
#     name  = "auth.enabled"
#     value = "true"
#   }
#
#   set {
#     name  = "auth.rootUser"
#     value = var.root_username
#   }
#
#   set {
#     name  = "auth.rootPassword"
#     value = var.root_password
#   }
#
#   set {
#     name  = "auth.username"
#     value = var.database_username
#   }
#
#   set {
#     name  = "auth.password"
#     value = var.database_password
#   }
#
#   set {
#     name  = "auth.database"
#     value = var.database_name
#   }
#
#   set {
#     name  = "persistence.enabled"
#     value = "true"
#   }
#
#   set {
#     name  = "persistence.size"
#     value = var.persistent_size
#   }
# }
#
#
# resource "kubernetes_service" "mongodb_lb" {
#   metadata {
#     name             = var.app_name
#     namespace        = var.namespace
#     annotations = {
#       service.beta.kubernetes.io/linode-loadbalancer-preserve: "true"
#     }
#   }
#   spec {
#     type = "LoadBalancer"
#     port {
#       port        = var.port
#       target_port = var.target_port
#       protocol    = "TCP"
#     }
#     selector = {
#       app.kubernetes.io/name  = helm_release.mongodb.name
#       app.kubernetes.io/instance = helm_release.mongodb.name
#     }
#   }
# }

resource "kubernetes_storage_class" "mongo_retain" {
  #   count = data.kubernetes_storage_class.existing_storage.metadata[0].uid != "" ? 0 : 1

  metadata {
    name = "${var.app_name}-storage-retain"
  }
  storage_provisioner    = "linodebs.csi.linode.com"
  reclaim_policy = "Retain"
  lifecycle {
    prevent_destroy = true       # don’t delete
    ignore_changes  = [metadata] # skip metadata diffs
  }
  parameters = {
    type = "ext4"
  }
}

data "kubernetes_storage_class" "existing_storage" {
  metadata {
    name = "${var.app_name}-storage-retain"
  }
}


resource "helm_release" "mongodb" {
  name       = var.app_name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "mongodb"
  version    = var.app_version  # use a version with externalAccess support
  namespace  = var.namespace
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
      #       externalAccess = {
      #         enabled = true
      #         service = {
      #           type = "LoadBalancer"
      #           port = 27017
      #           annotations = {
      #             "service.beta.kubernetes.io/linode-loadbalancer-nodebalancer-id" = "carozza-balancer"//linode_nodebalancer.mongodb.id
      #           }
      #         }
      #       }
      rbac = { create = true }
    })
  ]
}




