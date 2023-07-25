resource "google_project_service" "project" {
  service = "storage.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = false
}


resource "google_storage_bucket" "bucket" {
  project = var.project_id

  name                        = var.bucket_name
  uniform_bucket_level_access = true
  location                    = var.default_region
  storage_class               = "STANDARD"
  public_access_prevention    = "enforced"
  encryption {
    default_kms_key_name = var.kms_key
  }
  force_destroy = false
}

resource "google_storage_bucket_iam_binding" "binding_admin" {
  count   = length(var.bucket_admin_members) > 0 ? 1 : 0
  bucket  = google_storage_bucket.bucket.name
  role    = "roles/storage.objectAdmin"
  members = var.bucket_admin_members
}

resource "google_storage_bucket_iam_binding" "binding_viewer" {
  count   = length(var.bucket_viewer_members) > 0 ? 1 : 0
  bucket  = google_storage_bucket.bucket.name
  role    = "roles/storage.objectViewer"
  members = var.bucket_viewer_members
}
