resource "google_project_service_identity" "sql" {
  provider = google-beta

  project = var.project_id
  service = "sqladmin.googleapis.com"
}


resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta

  project       = var.project_id
  name          = "private-ip-${var.sql_instance_name}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.vpc_id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network                 = var.vpc_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_sql_database_instance" "main" {
  provider = google-beta

  project = var.project_id

  name                = var.sql_instance_name
  database_version    = var.db_version
  region              = var.default_region
  encryption_key_name = var.kms_key_name
  deletion_protection = false

  settings {
    tier = var.db_instance_size
    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = var.vpc_id
      enable_private_path_for_google_cloud_services = true
    }
  }

  depends_on = [
    google_service_networking_connection.private_vpc_connection,
    google_project_service_identity.sql
  ]
}

resource "google_sql_database" "database" {
  project = var.project_id

  name     = var.database_name
  instance = google_sql_database_instance.main.name
  charset  = "UTF8"
}

resource "random_password" "pwd" {
  length  = 16
  special = false
}

resource "google_sql_user" "user" {
  project = var.project_id

  name     = var.database_username
  instance = google_sql_database_instance.main.name
  password = random_password.pwd.result
}
