variable "project_id" {
  type        = string
  description = "The GCP project id"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID"
}

variable "sql_instance_name" {
  type        = string
  description = "The Cloud sql instance name"
}

variable "db_instance_size" {
  type        = string
  description = "The Cloud sql instance size"
}

variable "db_version" {
  type        = string
  description = "The MySQL, PostgreSQL or SQL Server version to use"
}

variable "default_region" {
  type        = string
  description = "Thes GCP region name"
  default     = "europe-west9"
}

variable "kms_key_name" {
  type        = string
  description = "The Kms Key Id for GCS (projects/{{project}}/locations/{{location}}/keyRings/{{keyRing}})/cryptoKeys/{{name}}"
}

variable "database_name" {
  type        = string
  description = "The database name"
}

variable "database_username" {
  type        = string
  description = "The database user name"
}
