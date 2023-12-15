output "keycloak_host" {
  description = "The hostname of the Keycloak server"
  value       = helm_release.keycloak_server.id
}

output "keycloak_host_version" {
  value = helm_release.keycloak_server.version
}

output "keycloak_host_status" {
  value = helm_release.keycloak_server.status
}