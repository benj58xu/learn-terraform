# AWS RDS Terraform Module

This Terraform module provisions an AWS RDS instance with commonly configurable parameters.

## Usage

```hcl
module "rds" {
  source = "./modules/rds"

  identifier = "my-database"
  engine     = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  allocated_storage = 20

  db_name  = "mydb"
  username = "admin"
  password = "mypassword"

  vpc_security_group_ids = ["sg-12345678"]
  db_subnet_group_name   = "my-subnet-group"

  tags = {
    Environment = "dev"
    Project     = "myproject"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| identifier | The name of the RDS instance | `string` | n/a | yes |
| engine | The database engine to use | `string` | `"mysql"` | no |
| engine_version | The engine version to use | `string` | `"8.0"` | no |
| instance_class | The instance type of the RDS instance | `string` | `"db.t3.micro"` | no |
| allocated_storage | The allocated storage in gigabytes | `number` | `20` | no |
| storage_type | One of 'standard', 'gp2', or 'io1' | `string` | `"gp2"` | no |
| db_name | The DB name to create | `string` | `null` | no |
| username | Username for the master DB user | `string` | `"admin"` | no |
| password | Password for the master DB user | `string` | n/a | yes |
| port | The port on which the DB accepts connections | `number` | `null` | no |
| vpc_security_group_ids | List of VPC security groups to associate | `list(string)` | `[]` | no |
| db_subnet_group_name | Name of DB subnet group | `string` | `null` | no |
| parameter_group_name | Name of the DB parameter group to associate | `string` | `null` | no |
| option_group_name | Name of the DB option group to associate | `string` | `null` | no |
| availability_zone | The Availability Zone of the RDS instance | `string` | `null` | no |
| multi_az | Specifies if the RDS instance is multi-AZ | `bool` | `false` | no |
| backup_retention_period | The days to retain backups for | `number` | `7` | no |
| backup_window | The daily time range for automated backups | `string` | `"03:00-06:00"` | no |
| maintenance_window | The window to perform maintenance in | `string` | `"sun:04:00-sun:04:30"` | no |
| monitoring_interval | The interval for Enhanced Monitoring metrics | `number` | `0` | no |
| monitoring_role_arn | The ARN for the IAM role for Enhanced Monitoring | `string` | `null` | no |
| enabled_cloudwatch_logs_exports | List of log types to enable for CloudWatch | `list(string)` | `[]` | no |
| deletion_protection | If the DB instance should have deletion protection | `bool` | `false` | no |
| skip_final_snapshot | Determines whether a final DB snapshot is created | `bool` | `false` | no |
| final_snapshot_identifier | The name of your final DB snapshot | `string` | `null` | no |
| copy_tags_to_snapshot | On delete, copy all Instance tags to the final snapshot | `bool` | `false` | no |
| tags | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| db_instance_id | The RDS instance ID |
| db_instance_arn | The ARN of the RDS instance |
| db_instance_endpoint | The connection endpoint |
| db_instance_address | The hostname of the RDS instance |
| db_instance_port | The database port |
| db_instance_name | The database name |
| db_instance_username | The master username for the database |
| db_instance_status | The RDS instance status |
| db_instance_ca_cert_identifier | Specifies the identifier of the CA certificate for the DB instance |
