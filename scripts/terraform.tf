terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "benj58xu-terraform-backend"
    use_lockfile = true
    region       = var.aws_region     /* this is replaced by sed */
    key = "will-be-overridden-by-command-line/terraform.tfstate"
  }

  required_version = ">= 1.2"
}


provider "aws" {
  region = var.aws_region   /* this is replaced by sed */
}
