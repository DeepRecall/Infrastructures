output "release_name" {
  description = "Casdoor Helm release name"
  value       = helm_release.casdoor.name
}

output "status" {
  description = "Casdoor Helm release status"
  value       = helm_release.casdoor.status
}

output "namespace" {
  description = "Namespace where Casdoor is deployed"
  value       = helm_release.casdoor.namespace
}