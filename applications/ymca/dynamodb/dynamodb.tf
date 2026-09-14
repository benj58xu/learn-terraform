resource "aws_dynamodb_table" "ymca_users" {
  name         = "ymca_users"
  billing_mode = "PAY_PER_REQUEST" # Use ON-DEMAND billing mode for simplicity and auto-scaling
  hash_key     = "username"

  attribute {
    name = "username"
    type = "S" # 'S' for String, 'N' for Number, 'B' for Binary
  }

  # other attributes:
  # first_name, last_name, password_encrypted, role (volunteer|admin), email, created_at, updated_at

  tags = {
    Environment = "Development"
    Project     = "YMCA_Volunteer"
  }
}

resource "aws_dynamodb_table" "ymca_volunteer_hours" {
  name         = "ymca_volunteer_hours"
  billing_mode = "PAY_PER_REQUEST" # Use ON-DEMAND billing mode for simplicity and auto-scaling
  hash_key     = "volunteer_id"
  range_key     = "start_time"

  attribute {
    name = "volunteer_id"
    type = "S"
  }

  attribute {
    name = "start_time" # e.g. 2026-08-31T09:00:00Z
    type = "S"
  }

  # other attributes:
  # end_time, created_at, updated_at

  tags = {
    Environment = "Development"
    Project     = "YMCA_Volunteer"
  }
}