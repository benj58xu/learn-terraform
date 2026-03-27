module "s3_bucket" {
  source = "../../../modules/s3-bucket"

  bucket_name         = "terraform"
  force_destroy       = true

  tags = {
    Environment = "dev"
    Project     = "learn-terraform"
  }
}