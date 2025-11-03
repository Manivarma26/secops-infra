variable "lambda_package" {
  description = "Path to the Lambda deployment package (.zip)"
  type        = string
}

variable "lambda_role_arn" {
  description = "IAM role ARN for Lambda execution"
  type        = string
}

variable "opensearch_endpoint" {
  description = "OpenSearch endpoint URL"
  type        = string
}

variable "index_name" {
  description = "OpenSearch index name"
  type        = string
  default     = "secops-compliance"
}

variable "s3_query_output_bucket_name" {
  description = "Name of the S3 bucket where Athena stores results"
  type        = string
}

variable "s3_query_output_bucket_arn" {
  description = "ARN of the S3 bucket for Lambda permissions"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}
