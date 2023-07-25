variable "project_id" {
  type        = string
  description = "The GCP project ID"
}
variable "repositories" {
  description = "The list of repository"
  type = list(object({
    location               = string
    repository_name        = string
    repository_description = string
    repository_format      = string
    kms_key_name           = string
  }))

}
