output "release_name" {
  description = "Milvus Helm release name"
  value       = helm_release.milvus.name
}

output "status" {
  description = "Milvus Helm release status"
  value       = helm_release.milvus.status
}

output "namespace" {
  description = "Namespace where Milvus is deployed"
  value       = helm_release.milvus.namespace
}