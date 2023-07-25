variable "backend_services" {
  type        = list(string)
  description = "List of GCP API to enable"
  default = [
    "sqladmin.googleapis.com",
    "cloudkms.googleapis.com",
    "storage.googleapis.com",
    "servicenetworking.googleapis.com",
    "serviceusage.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com"
  ]
}

variable "project_id" {
  type        = string
  description = "The GCP project ID"
}

variable "default_region" {
  type        = string
  description = "The GCP region name"
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
variable "vpc_name" {
  type        = string
  description = "The name of the new VPC"
}
