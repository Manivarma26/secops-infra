# Glue Database
resource "aws_glue_catalog_database" "secops_db" {
  name = var.database_name
  description = "Glue database for storing SecOps compliance metadata"
  tags = merge(var.tags, { Module = "GlueAthena" })
}

# Glue Crawler — scans S3 compliance reports
resource "aws_glue_crawler" "secops_crawler" {
  name         = "${var.database_name}-crawler"
  role         = var.glue_iam_role_arn
  database_name = aws_glue_catalog_database.secops_db.name
  table_prefix  = "compliance_"
  description   = "Crawler for discovering compliance report schema"

  s3_target {
    path = var.s3_data_path
  }

  schedule = "cron(0 2 * * ? *)" # runs daily at 2 AM

  tags = merge(var.tags, { Module = "GlueAthena" })
}

# Athena Workgroup — executes queries on compliance data
resource "aws_athena_workgroup" "secops_wg" {
  name = var.workgroup_name
  configuration {
    result_configuration {
      output_location = var.query_output_location
      encryption_configuration {
        encryption_option = "SSE_KMS"
        kms_key_arn       = var.kms_key_arn
      }
    }
  }
  tags = merge(var.tags, { Module = "GlueAthena" })
}
