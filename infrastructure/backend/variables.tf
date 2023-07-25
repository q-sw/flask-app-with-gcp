###################
##### GENERAL #####
###################

variable "project_id" {
  type        = string
  description = "The GCPP project ID"
}

variable "default_region" {
  type        = string
  description = "The GCP region use to deploy"
  default     = "europe-west9"
}

variable "vpc_id" {
  type        = string
  description = "The VPC name create for the project"

}

###################
###### GCS ########
###################

variable "bucket_name" {
  type        = string
  description = "The GCS bucket name"
}

variable "gcs_kms_key" {
  type        = string
  description = "The Kms Key Id (projects/{{project}}/locations/{{location}}/keyRings/{{keyRing}})/cryptoKeys/{{name}}"
}


##################
##### SQL ########
##################


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

variable "sql_kms_key" {
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
