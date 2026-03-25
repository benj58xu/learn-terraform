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
    region       = var.aws_region
    /* 1. Need to change this for the current stack */
    key = "will-be-overridden-by-command-line/terraform.tfstate"
  }

  required_version = ">= 1.2"
}


provider "aws" {
  region = var.aws_region
}


/*
You may need to run "terraform init -reconfigure" to forget .terraform/terraform.tfstate
*/
