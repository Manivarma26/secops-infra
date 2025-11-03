output "opensearch_endpoint" {
  description = "OpenSearch domain endpoint"
  value       = aws_opensearch_domain.secops.endpoint
}

output "opensearch_arn" {
  description = "ARN of the OpenSearch domain"
  value       = aws_opensearch_domain.secops.arn
}
