output "database_host" {
  description = "The hostname of the PostgreSQL database server"
  value       = "${helm_release.postgresql_helm_release.id}-postgresql"
}

output "database_secret" {
  description = "The password of the PostgreSQL database server"
  value       = helm_release.postgresql_helm_release.metadata
}

output "database_host_version" {
  value = helm_release.postgresql_helm_release.version
}

output "database_host_status" {
  value = helm_release.postgresql_helm_release.status
}