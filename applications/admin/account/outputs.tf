output "account_id" {
  description = "The ID of the created AWS account"
  value       = aws_organizations_account.account.id
}

output "account_arn" {
  description = "The ARN of the created AWS account"
  value       = aws_organizations_account.account.arn
}

output "account_email" {
  description = "The email address of the created AWS account"
  value       = aws_organizations_account.account.email
}