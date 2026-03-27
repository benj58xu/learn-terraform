# AWS Account Creation Module

This Terraform module creates a new AWS account within an AWS Organization, which can then be enrolled in AWS Control Tower for governance.

## Prerequisites

- AWS Organization must be set up
- AWS Control Tower landing zone deployed (optional but recommended for governance)
- Appropriate permissions to create accounts in the organization
- Organizational Unit (OU) ID where the account should be placed

## Usage

```hcl
module "account" {
  source = "./applications/admin/account"

  account_name        = "my-new-account"
  account_email       = "admin@mycompany.com"
  organizational_unit = "ou-1234-56789012"  # Replace with actual OU ID
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| account_name | The name of the AWS account to create | `string` | n/a | yes |
| account_email | The email address for the AWS account | `string` | n/a | yes |
| organizational_unit | The parent organizational unit ID to place the account in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| account_id | The ID of the created AWS account |
| account_arn | The ARN of the created AWS account |
| account_email | The email address of the created AWS account |

## Notes

- After creating the account with this module, you may need to enroll it in AWS Control Tower through the AWS Console
- The account will have IAM user access to billing enabled by default
- A cross-account role named "OrganizationAccountAccessRole" will be created for organization management
- Account creation may take several minutes to complete

## Troubleshooting

- Ensure the email address is not already associated with an AWS account
- Verify the OU ID exists in your organization
- Check that you have the necessary permissions (`organizations:CreateAccount`)