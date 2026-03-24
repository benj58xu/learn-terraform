variable "user_name" {
  description = "IAM user name for direct access (optional if create_iam_user = false)"
  type        = string
  default     = "github-actions-user"
}

variable "user_path" {
  description = "IAM user path"
  type        = string
  default     = "/"
}

variable "create_iam_user" {
  description = "Whether to create an IAM user"
  type        = bool
  default     = true
}

variable "create_access_key" {
  description = "Whether to create an access key for the IAM user"
  type        = bool
  default     = false
}

variable "github_org" {
  description = "GitHub organization owning the repository (OIDC subject)"
  type        = string
  default     = ""
}

variable "github_repo" {
  description = "GitHub repository name for OIDC subject. Use '*' for org-wide."
  type        = string
  default     = "*"
}

variable "github_branch" {
  description = "GitHub branch/ref filter for OIDC subject. Use '*' for any branch"
  type        = string
  default     = "*"
}

variable "create_github_actions_role" {
  description = "Whether to create a GitHub Actions OIDC role"
  type        = bool
  default     = true
}

variable "rds_actions" {
  description = "List of RDS permissions for the role/user"
  type        = list(string)
  default = [
    "rds:CreateDBInstance",
    "rds:DeleteDBInstance",
    "rds:DescribeDBInstances",
    "rds:ModifyDBInstance",
    "rds:DescribeDBSubnetGroups",
    "rds:DescribeDBSecurityGroups",
    "rds:DescribeDBParameterGroups",
    "rds:ListTagsForResource"
  ]
}

variable "s3_actions" {
  description = "List of S3 permissions for the role/user"
  type        = list(string)
  default = [
    "s3:ListBucket",
    "s3:GetObject",
    "s3:PutObject",
    "s3:DeleteObject"
  ]
}

variable "tags" {
  description = "Common tags applied to IAM resources"
  type        = map(string)
  default     = {}
}
