variable "database_name" {
  description = "Glue database name"
  type        = string
}

variable "glue_iam_role_arn" {
  description = "IAM role ARN for Glue crawler"
  type        = string
}

variable "s3_data_path" {
  description = "S3 path for compliance data (S3 bucket URI)"
  type        = string
}

variable "workgroup_name" {
  description = "Athena workgroup name"
  type        = string
}

variable "query_output_location" {
  description = "S3 path for Athena query results"
  type        = string
}

variable "kms_key_arn" {
  description = "KMS key ARN for encryption"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
