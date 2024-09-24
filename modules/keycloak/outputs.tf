output "keycloak_host" {
  description = "The hostname of the Keycloak server"
  value       = helm_release.keycloak_helm_release.id
}

output "keycloak_host_version" {
  value = helm_release.keycloak_helm_release.version
}

output "keycloak_host_status" {
  value = helm_release.keycloak_helm_release.status
}