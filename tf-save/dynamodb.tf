provider "aws" {
  region = "us-east-2"
}

resource "aws_dynamodb_table" "example_table" {
  name         = "MusicCollection"
  billing_mode = "PAY_PER_REQUEST" # Use ON-DEMAND billing mode for simplicity and auto-scaling
  hash_key     = "ArtistId"

  attribute {
    name = "ArtistId"
    type = "S" # 'S' for String, 'N' for Number, 'B' for Binary
  }

  tags = {
    Environment = "Development"
    Project     = "MusicApp"
  }
}
