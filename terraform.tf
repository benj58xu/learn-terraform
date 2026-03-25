terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  backend "s3" {
    bucket       = "benj58xu-terraform-backend"
    use_lockfile = true
    region       = "us-east-2" /* always use this region for tfstate files */
    /* 1. Need to change this for the current stack */
    key = "will-be-overridden-by-command-line/terraform.tfstate"
  }

  required_version = ">= 1.2"
}

/*
You may need to run "terraform init -reconfigure" to forget .terraform/terraform.tfstate
*/
