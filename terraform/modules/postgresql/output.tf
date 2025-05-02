output "postgresql_primary_service" {
  value = "${helm_release.postgresql.metadata[0].name}-postgresql"
}

output "postgresql_replica_service" {
  value = "${helm_release.postgresql.metadata[0].name}-postgresql-read"
}

output "postgresql_port" {
  value = "5432"
}