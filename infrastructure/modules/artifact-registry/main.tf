resource "google_project_service" "project" {
  service = "artifactregistry.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = false
}

resource "google_project_service_identity" "identity" {
  provider = google-beta

  project = var.project_id
  service = "artifactregistry.googleapis.com"
}

resource "time_sleep" "wait_30_seconds" {
  create_duration = "30s"

  depends_on = [google_project_service.project]
}


resource "google_artifact_registry_repository" "repository" {
  count         = length(var.repositories)
  project       = var.project_id
  location      = element(var.repositories.*.location, count.index)
  repository_id = element(var.repositories.*.repository_name, count.index)
  description   = element(var.repositories.*.repository_description, count.index)
  format        = element(var.repositories.*.repository_format, count.index)
  kms_key_name  = element(var.repositories.*.kms_key_name, count.index)

  depends_on = [
    google_project_service.project,
    time_sleep.wait_30_seconds
  ]
}
