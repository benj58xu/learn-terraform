provider "aws" {
  region = "us-east-2"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default_vpc" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_subnet" "subnet_details" {
  for_each = toset(data.aws_subnets.default_vpc.ids)
  id       = each.value
}

/*
resource "aws_db_subnet_group" "ben-subnet-group" {
  name       = "ben-subnet-group"
  subnet_ids = [
    "subnet-03a5266624fa2c71d",
    "subnet-085aa49c5835968bd"
  ]
  tags = {
    Name = "ben-subnet-group"
  }
}
*/

locals {
  subnets_by_az  = { for s in data.aws_subnet.subnet_details : s.availability_zone => s.id }
  rds_subnet_ids = slice(values(local.subnets_by_az), 0, 2)
}

resource "aws_db_subnet_group" "ben-subnet-group" {
  name       = "ben-subnet-group"
  subnet_ids = local.rds_subnet_ids

  tags = {
    Name = "ben-subnet-group"
  }
}

resource "aws_security_group" "mysql" {
  name        = "mysql-security-group"
  description = "Security group for MySQL RDS instance"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mysql-sg"
  }
}

/*
Q1: how to find existing subnet subnet_ids
Q2: how to find existing security group ids

if skip_final_snapshot is false, cannot destroy the database instance
unless final_snapshot_identifier is provided when creating the database
*/

module "rds" {
  source = "./modules/rds"

  identifier        = "my-database"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "mydb"
  username = "admin"
  password = "mypassword"

  vpc_security_group_ids = [aws_security_group.mysql.id]
  db_subnet_group_name   = "ben-subnet-group"

  backup_retention_period = 0
  skip_final_snapshot     = true

  tags = {
    Environment = "dev"
    Project     = "myproject"
  }

  depends_on = [aws_db_subnet_group.ben-subnet-group]
}

