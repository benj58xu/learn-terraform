output "iam_user_name" {
  value       = var.create_iam_user ? aws_iam_user.this[0].name : null
  description = "IAM user name created by this module"
}

output "iam_user_arn" {
  value       = var.create_iam_user ? aws_iam_user.this[0].arn : null
  description = "IAM user ARN created by this module"
}

output "access_key_id" {
  value       = (var.create_iam_user && var.create_access_key) ? aws_iam_access_key.this[0].id : null
  description = "IAM access key ID"
  sensitive   = true
}

output "secret_access_key" {
  value       = (var.create_iam_user && var.create_access_key) ? aws_iam_access_key.this[0].secret : null
  description = "IAM access key secret"
  sensitive   = true
}

output "github_oidc_provider_arn" {
  value       = var.create_github_actions_role ? aws_iam_openid_connect_provider.github_actions[0].arn : null
  description = "GitHub Actions OIDC provider ARN"
}

output "github_actions_role_arn" {
  value       = var.create_github_actions_role ? aws_iam_role.github_actions_role[0].arn : null
  description = "Role ARN for GitHub Actions to assume"
}
