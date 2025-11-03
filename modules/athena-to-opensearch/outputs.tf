output "lambda_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.index_athena_results.function_name
}
