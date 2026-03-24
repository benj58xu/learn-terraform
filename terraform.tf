terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  backend "s3" {
    bucket = "benj58xu-terraform-backend"
    use_lockfile = true
    /* Need to change this for the current stack */
    key          = "applications/app1/rds/terraform.tfstate"
    /* Need to change this for the current stack */
    region       = "us-east-2"
  }

  required_version = ">= 1.2"
}

module "current_stack" {
  /* Need to change this for the current stack */
  source = "./applications/app1/rds"
}

/*
You may need to run "terraform init -reconfigure" to forget the current Statement
*/
