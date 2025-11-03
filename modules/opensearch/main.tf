resource "aws_opensearch_domain" "secops" {
  domain_name = var.domain_name

  engine_version = "OpenSearch_2.13"

  cluster_config {
    instance_type  = "t3.small.search"
    instance_count = 2
    zone_awareness_enabled = false
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 20
    volume_type = "gp3"
  }

  encrypt_at_rest {
    enabled    = true
    kms_key_id = var.kms_key_arn
  }

  node_to_node_encryption {
    enabled = true
  }

  domain_endpoint_options {
    enforce_https = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  access_policies = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = { AWS = "*" },
        Action   = "es:*",
        Resource = "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain_name}/*",
        Condition = {
          IpAddress = { "aws:SourceIp" = var.allowed_ip }
        }
      }
    ]
  })

  tags = merge(var.tags, {
    Module = "OpenSearch"
  })
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
