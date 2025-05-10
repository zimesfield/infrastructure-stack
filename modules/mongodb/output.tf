output "mongodb_primary_service" {
  value = helm_release.mongodb.status
}