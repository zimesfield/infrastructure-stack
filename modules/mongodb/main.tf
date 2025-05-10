resource "helm_release" "mongodb" {
  name       = var.app_name
  namespace  = var.namespace
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "mongodb"
  version    = var.app_version

  set {
    name  = "auth.enabled"
    value = "true"
  }

  set {
    name  = "auth.rootUser"
    value = var.root_username
  }

  set {
    name  = "auth.rootPassword"
    value = var.root_password
  }

  set {
    name  = "auth.username"
    value = var.database_username
  }

  set {
    name  = "auth.password"
    value = var.database_password
  }

  set {
    name  = "auth.database"
    value = var.database_name
  }

  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "persistence.size"
    value = var.persistent_size
  }
}


resource "kubernetes_service" "mongodb_lb" {
  metadata {
    name             = var.app_name
    namespace        = var.namespace
    annotations = {
      service.beta.kubernetes.io/linode-loadbalancer-preserve: "true"
    }
  }
  spec {
    type = "LoadBalancer"
    port {
      port        = var.port
      target_port = var.target_port
      protocol    = "TCP"
    }
    selector = {
      app.kubernetes.io/name  = helm_release.mongodb.name
      app.kubernetes.io/instance = helm_release.mongodb.name
    }
  }
}