output "registry" {
  value = google_artifact_registry_repository.repository.*
}

output "service_account" {
  value = google_project_service_identity.identity.email
}

