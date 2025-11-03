resource "aws_kms_key" "secops" {
  description             = var.description
  enable_key_rotation     = true
  deletion_window_in_days = 10

  tags = merge(var.tags, {
    Module = "KMS"
  })
}

resource "aws_kms_alias" "secops_alias" {
  name          = "alias/${var.alias_name}"
  target_key_id = aws_kms_key.secops.key_id
}
