output "glue_database_name" {
  description = "Glue database name"
  value       = aws_glue_catalog_database.secops_db.name
}

output "athena_workgroup_name" {
  description = "Athena workgroup name"
  value       = aws_athena_workgroup.secops_wg.name
}
