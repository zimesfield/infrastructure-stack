#
#
# # Output the external IP or DNS of the LoadBalancer
# output "keycloak_service_ip" {
#   value = kubernetes_service.keycloak.status.0.load_balancer.0.ingress.0.ip
#   # Alternatively, use hostname if the service uses DNS
#   # value = kubernetes_service.keycloak.status.0.load_balancer.0.ingress.0.hostname
# }