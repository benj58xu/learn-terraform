resource "aws_db_instance" "this" {
  identifier = var.identifier

  engine         = var.engine
  engine_version = var.engine_version

  instance_class = var.instance_class

  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type

  db_name  = var.db_name
  username = var.username
  password = var.password
  port     = var.port

  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name   = var.db_subnet_group_name

  parameter_group_name = var.parameter_group_name
  option_group_name    = var.option_group_name

  availability_zone = var.availability_zone
  multi_az          = var.multi_az

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window

  maintenance_window = var.maintenance_window

  monitoring_interval             = var.monitoring_interval
  monitoring_role_arn             = var.monitoring_role_arn
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  deletion_protection = var.deletion_protection

  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier
  copy_tags_to_snapshot     = var.copy_tags_to_snapshot

  tags = var.tags
}