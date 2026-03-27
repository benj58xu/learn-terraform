variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "acl" {
  description = "The canned ACL to apply"
  type        = string
  default     = "private"
}

variable "versioning" {
  description = "Whether to enable versioning"
  type        = bool
  default     = false
}

variable "encrypt" {
  description = "Whether to enable server-side encryption (SSE-S3)"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Allow deleting non-empty buckets"
  type        = bool
  default     = false
}

variable "block_public_access" {
  description = "Block public access settings"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the bucket"
  type        = map(string)
  default     = {}
}
