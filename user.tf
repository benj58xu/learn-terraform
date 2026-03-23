provider "aws" {
  region = "us-east-2"
  assume_role {
    role_arn = "arn:aws:iam::821080507765:role/github-actions-user-github-actions-role"
  }
}

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
