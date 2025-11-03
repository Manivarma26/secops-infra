variable "domain_name" {
  description = "OpenSearch domain name"
  type        = string
}

variable "kms_key_arn" {
  description = "KMS key ARN for encryption"
  type        = string
}

variable "allowed_ip" {
  description = "Allowed public IP address for access (CIDR format)"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
