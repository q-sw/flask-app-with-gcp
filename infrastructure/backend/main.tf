module "gcs" {
  source = "../../modules/gcs"

  project_id     = var.project_id
  bucket_name    = var.bucket_name
  default_region = var.default_region
  kms_key        = var.gcs_kms_key
}


module "sql" {
  source = "../../modules/sql"

  project_id        = var.project_id
  vpc_id            = var.vpc_id
  sql_instance_name = var.sql_instance_name
  db_version        = var.db_version
  db_instance_size  = var.db_instance_size
  kms_key_name      = var.sql_kms_key
  database_name     = var.database_name
  database_username = var.database_username
}
