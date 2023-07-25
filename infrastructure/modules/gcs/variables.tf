variable "project_id" {
  type        = string
  description = "The GCPP project ID"
}

variable "bucket_name" {
  type        = string
  description = "The GCS bucket name"
}

variable "default_region" {
  type        = string
  description = "The GCP region use to deploy"
  default     = "europe-west9"
}

variable "kms_key" {
  type        = string
  description = "The Kms Key Id (projects/{{project}}/locations/{{location}}/keyRings/{{keyRing}})/cryptoKeys/{{name}}"
}

variable "bucket_admin_members" {
  type        = list(string)
  description = "The list of principal that have storage.objectAdmin permission"
  default     = []
}

variable "bucket_viewer_members" {
  type        = list(string)
  description = "The list of principal that have storage.objectViewer permission"
  default     = []
}
