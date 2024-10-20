resource "helm_release" "elasticsearch" {
  name       = var.service_name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "elasticsearch"
  namespace  = var.namespace
  version    = var.app_version

  set {
    name  = "master.replicaCount"
    value = var.replicaCount
  }

  set {
    name  = "master.masterOnly"
    value = false
  }

  set {
    name  = "data.replicaCount"
    value = 0
  }

  set {
    name  = "coordinating.replicaCount"
    value = 0
  }

  set {
    name  = "ingest.enabled"
    value = false
  }

  set {
    name  = "ingest.replicaCount"
    value = 0
  }

  set {
    name  = "resources.requests.memory"
    value = "512Mi"
  }

  set {
    name  = "resources.requests.cpu"
    value = "500m"
  }

  set {
    name  = "elasticsearchJavaOpts"
    value = "-Xmx1024m -Xms1024m"  # Set JVM heap size
  }

  set {
    name  = "service.type"
    value = "ClusterIP"  # Change to "LoadBalancer" for external access
  }

  set {
    name  = "service.ports.http"
    value = "9200"  # Port for HTTP traffic
  }

  set {
    name  = "service.ports.transport"
    value = "9300"  # Port for transport traffic
  }
}

# Get the Elasticsearch service details
data "kubernetes_service" "elasticsearch" {
  metadata {
    name      = helm_release.elasticsearch.name
    namespace = helm_release.elasticsearch.namespace
  }
}
