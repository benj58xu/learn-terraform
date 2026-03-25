
module "github_actions_user" {
  source = "./modules/user"

  user_name                  = "github-actions-user"
  create_iam_user            = true
  create_access_key          = false
  create_github_actions_role = true

  github_org    = "benj58xu"
  github_repo   = "learn-terraform"
  github_branch = "*"

  tags = {
    Environment = "dev"
    Project     = "myproject"
  }
}
