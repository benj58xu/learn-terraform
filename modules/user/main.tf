locals {
  github_subject             = "repo:${var.github_org}/${var.github_repo}:ref:refs/heads/${var.github_branch}"
  infrastructure_policy_name = "${var.user_name}-infrastructure-management-policy"
}

resource "aws_iam_user" "this" {
  count = var.create_iam_user ? 1 : 0
  name  = var.user_name
  path  = var.user_path
  tags  = merge(var.tags, { "managed-by" = "terraform" })
}

resource "aws_iam_access_key" "this" {
  count = (var.create_iam_user && var.create_access_key) ? 1 : 0
  user  = aws_iam_user.this[0].name
}

resource "aws_iam_policy" "infrastructure_management" {
  name        = local.infrastructure_policy_name
  description = "Infrastructure management permissions for GitHub Actions and user"
  path        = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = concat(var.rds_actions, var.s3_actions, [
            "ec2:DescribeVpcs",
            "ec2:DescribeVpcAttribute",
            "ec2:DescribeSubnets",
            "ec2:DescribeSecurityGroups",
            "ec2:CreateSecurityGroup",
            "ec2:CreateTags",
            "ec2:RevokeSecurityGroupEgress",
            "ec2:RevokeSecurityGroupIngress",
            "ec2:AuthorizeSecurityGroupEgress",
            "ec2:AuthorizeSecurityGroupIngress",
            "ec2:DescribeNetworkInterfaces",
            "ec2:DeleteSecurityGroup" ])
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "infrastructure_management_attach" {
  count      = var.create_iam_user ? 1 : 0
  user       = aws_iam_user.this[0].name
  policy_arn = aws_iam_policy.infrastructure_management.arn
}

resource "aws_iam_openid_connect_provider" "github_actions" {
  count = var.create_github_actions_role ? 1 : 0

  url = "https://token.actions.githubusercontent.com"

  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

resource "aws_iam_role" "github_actions_role" {
  count = var.create_github_actions_role ? 1 : 0

  name = "${var.user_name}-github-actions-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github_actions[0].arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = local.github_subject
          }
        }
      }
    ]
  })

  tags = merge(var.tags, { "managed-by" = "terraform" })
}

resource "aws_iam_role_policy_attachment" "github_actions_infrastructure_attach" {
  count      = var.create_github_actions_role ? 1 : 0
  role       = aws_iam_role.github_actions_role[0].name
  policy_arn = aws_iam_policy.infrastructure_management.arn
}
