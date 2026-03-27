# AWS S3 Bucket Module

Terraform module for creating an S3 bucket with common security and lifecycle defaults.

## Features

- Custom bucket name and ACL
- Optional versioning
- Optional server-side encryption (SSE-S3)
- Optional public access block
- Optional force destroy for non-empty bucket deletion
- Tags support

## Usage

```hcl
module "s3_bucket" {
  source = "../modules/s3-bucket"

  bucket_name         = "my-terraform-bucket"
  acl                 = "private"
  versioning          = true
  encrypt             = true
  block_public_access = true
  force_destroy       = false

  tags = {
    Environment = "dev"
    Project     = "learn-terraform"
  }
}
```

## Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| bucket_name | string | n/a | Name of the bucket |
| acl | string | `private` | Canned ACL |
| versioning | bool | `false` | Enable versioning |
| encrypt | bool | `true` | Enable server-side encryption SSE-S3 |
| force_destroy | bool | `false` | Allow destroy of non-empty bucket |
| block_public_access | bool | `true` | Block all public access settings |
| tags | map(string) | `{}` | Bucket tags |

## Outputs

| Name | Description |
|------|-------------|
| bucket_id | Bucket ID |
| bucket_arn | Bucket ARN |
| bucket_domain_name | Bucket domain name |
| bucket_regional_domain_name | Bucket regional domain name |
