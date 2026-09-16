variable "lambda_zip_path" {
  description = "Path to the prebuilt Lambda ZIP, relative to this stack directory."
  type        = string
  default     = "lambda_package.zip"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  function_name = "ymca-lambda"
  table_arns = [
    "arn:aws:dynamodb:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:table/ymca_users",
    "arn:aws:dynamodb:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:table/ymca_volunteer_hours",
  ]

  tags = {
    soa_application_name     = "ymca"
    soa_application_team     = "ymca"
    soa_environment          = "development"
    soa_data_classification  = "internal"
    soa_business_criticality = "medium"
    soa_owner_email          = "infrastructure@example.com"
  }
}

resource "aws_iam_role" "lambda" {
  name = "${local.function_name}-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "lambda" {
  name = "${local.function_name}-policy"
  role = aws_iam_role.lambda.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ]
        Resource = "arn:aws:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:*"
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:BatchGetItem",
          "dynamodb:BatchWriteItem",
          "dynamodb:DeleteItem",
          "dynamodb:DescribeTable",
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:UpdateItem",
        ]
        Resource = local.table_arns
      },
    ]
  })
}

resource "aws_lambda_function" "ymca" {
  function_name    = local.function_name
  role             = aws_iam_role.lambda.arn
  runtime          = "python3.12"
  handler          = "handler.lambda_handler"
  filename         = "${path.module}/${var.lambda_zip_path}"
  source_code_hash = filebase64sha256("${path.module}/${var.lambda_zip_path}")

  environment {
    variables = {
      USERS_TABLE = "ymca_users"
      HOURS_TABLE = "ymca_volunteer_hours"
    }
  }

  tags = local.tags
}