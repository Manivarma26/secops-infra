resource "aws_s3_bucket" "compliance" {
  bucket = var.bucket_name

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    enabled = true
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    expiration {
      days = 365
    }
  }

  tags = merge(var.tags, {
    Module = "S3"
  })
}
