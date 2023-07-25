output "sql-user-name" {
  value = google_sql_user.user.name
}

output "sql-password" {
  value     = random_password.pwd.result
  sensitive = true
}

output "service_account" {
  value = google_project_service_identity.sql.email
}
