variable "description" {
  description = "KMS key description"
  type        = string
  default     = "KMS key for SecOps encryption"
}

variable "alias_name" {
  description = "Alias for the KMS key"
  type        = string
}

variable "tags" {
  description = "Tags for the KMS key"
  type        = map(string)
  default     = {}
}
