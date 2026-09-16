resource "aws_s3_bucket" "frontend" {
  bucket = "ymca-frontend-demo-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.region}"
  force_destroy = true

  tags = {
    soa_application_name     = "ymca"
    soa_application_team     = "ymca"
    soa_environment          = "development"
    soa_data_classification  = "internal"
    soa_business_criticality = "medium"
    soa_owner_email          = "infrastructure@example.com"
  }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_s3_bucket_website_configuration" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = ["${aws_s3_bucket.frontend.arn}/*"]
      }
    ]
  })
}

resource "aws_route53_record" "frontend" {
  count = var.route53_zone_id != "" ? 1 : 0

  zone_id = var.route53_zone_id
  name    = var.route53_record_name
  type    = "A"

  alias {
    name                   = aws_s3_bucket_website_configuration.frontend.website_endpoint
    zone_id                = aws_s3_bucket.frontend.hosted_zone_id
    evaluate_target_health = true
  }
}

variable "route53_zone_id" {
  description = "Hosted zone ID for the demo domain. Leave empty to skip Route53 record creation."
  type        = string
  default     = ""
}

variable "route53_record_name" {
  description = "DNS name to create under the hosted zone, e.g. demo"
  type        = string
  default     = "demo"
}