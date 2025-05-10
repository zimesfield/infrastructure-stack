resource "helm_release" "postgresql" {
  name             = var.app_name
  namespace        = var.namespace_name
  chart            = var.chart_name
  repository       = "https://charts.bitnami.com/bitnami"
  create_namespace = true
  version          = var.app_version

  set {
    name = "primary.persistence.mountPath"
    value = "/bitnami/postgres"
  }

  set {
    name  = "auth.username"
    value = var.db_username
  }

  set_sensitive {
    name  = "auth.password"
    value = var.db_password
  }

  set {
    name  = "auth.database"
    value = var.db_name
  }

  set {
    name  = "primary.service.port"
    value = "5432"
  }

  set {
    name  = "primary.service.type"
    value = "ClusterIP"  # Can be LoadBalancer if needed
  }

  set {
    name  = "primary.service.name"
    value = "${var.app_name}-svc"
  }

}


resource "kubernetes_service" "postgresql_lb" {
  metadata {
    name             = var.app_name
    namespace        = var.namespace_name
    annotations = {
      service.beta.kubernetes.io/linode-loadbalancer-preserve: "true"
    }
  }
  spec {
    type = "LoadBalancer"
    port {
      port        = 5432
      target_port = 5432
      protocol    = "TCP"
    }
    selector = {
      app.kubernetes.io/name  = helm_release.postgresql.name
      app.kubernetes.io/instance = helm_release.postgresql.name
    }
  }
}
