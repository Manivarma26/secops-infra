resource "aws_lambda_function" "index_athena_results" {
  filename         = var.lambda_package
  function_name    = "secops-athena-opensearch-indexer"
  role             = var.lambda_role_arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.11"
  timeout          = 30
  memory_size      = 256
  environment {
    variables = {
      OPENSEARCH_ENDPOINT = var.opensearch_endpoint
      INDEX_NAME          = var.index_name
      REGION              = var.region
    }
  }
}

resource "aws_lambda_permission" "allow_s3_trigger" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.index_athena_results.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.s3_query_output_bucket_arn
}

resource "aws_s3_bucket_notification" "trigger_lambda" {
  bucket = var.s3_query_output_bucket_name

  lambda_function {
    lambda_function_arn = aws_lambda_function.index_athena_results.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "query-results/"
  }
}
