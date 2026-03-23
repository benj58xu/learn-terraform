# Terraform Module: user

Module to provision IAM access for GitHub Actions and RDS management in AWS.

## Features

- Optional IAM user creation
- Optional access key creation
- GitHub Actions OIDC provider and role configuration
- AWS IAM policy for safe RDS management operations

## Usage

```hcl
module "github_actions_user" {
  source = "../modules/user"

  user_name                 = "github-actions-user"
  create_iam_user           = true
  create_access_key         = false
  create_github_actions_role = true

  github_org   = "your-github-org"
  github_repo  = "your-repo"
  github_branch = "main"

  tags = {
    Environment = "dev"
    Project     = "myproject"
  }
}
```

## Inputs

- `user_name` (string, default `"github-actions-user"`): IAM user name.
- `user_path` (string, default `"/"`): IAM user path.
- `create_iam_user` (bool, default `true`): create IAM user.
- `create_access_key` (bool, default `false`): create access key for the IAM user.
- `github_org` (string, default `""`): GitHub org used in OIDC subject rule.
- `github_repo` (string, default `"*"`): GitHub repo used in OIDC subject rule.
- `github_branch` (string, default `"*"`): GitHub branch/ref used in OIDC subject rule.
- `create_github_actions_role` (bool, default `true`): create OIDC IAM role for GitHub Actions.
- `rds_actions` (list(string)): custom action list, defaults to essential RDS + EC2 describe calls.
- `tags` (map(string), default `{}`): tags on IAM resources.

## Outputs

- `iam_user_name`
- `iam_user_arn`
- `access_key_id`
- `secret_access_key` (sensitive)
- `github_oidc_provider_arn`
- `github_actions_role_arn`

## Notes

- Keep `create_access_key` false for security when using OIDC role.
- Update `github_org`, `github_repo`, and `github_branch` to match your workflows.
- Use the generated `github_actions_role_arn` in your GitHub Actions workflow `aws-actions/configure-aws-credentials` step.

## Example GitHub Actions snippet

```yaml
- name: Configure AWS credentials
  uses: aws-actions/configure-aws-credentials@v2
  with:
    role-to-assume: "${{ secrets.AWS_ROLE_ARN }}"
    aws-region: us-east-2
    role-session-name: github-actions
```