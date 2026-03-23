terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  backend "s3" {
    bucket       = "benj58xu-terraform-backend"
    key          = "infrastructure/terraform.tfstate"
    region       = "us-east-2"
    use_lockfile = true
  }

  required_version = ">= 1.2"
}
