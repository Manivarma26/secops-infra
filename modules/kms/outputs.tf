output "kms_key_arn" {
  description = "ARN of the KMS key"
  value       = aws_kms_key.secops.arn
}

output "kms_alias_name" {
  description = "Alias of the KMS key"
  value       = aws_kms_alias.secops_alias.name
}
