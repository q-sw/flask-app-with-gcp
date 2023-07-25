output "pg_sql_user" {
  value = module.sql.sql-user-name
}

output "pg_sql_pwd" {
  value = module.sql.sql-password
  sensitive = true
}
