resource "aws_rds_cluster" "main" {
  engine                          = "aurora-mysql"
  engine_version                  = "8.0.mysql_aurora.3.04.2"
  engine_mode                     = "provisioned"
  port                            = 3306
  cluster_identifier              = local.name_prefix
  availability_zones              = var.availability_zones
  database_name                   = var.database_name
  master_username                 = var.master_username
  master_password                 = var.master_password # Updates via AWS console
  backup_retention_period         = 1
  preferred_backup_window         = "07:00-06:00"
  apply_immediately               = true
  db_cluster_parameter_group_name = "default.aurora-mysql8.0"
  skip_final_snapshot             = true
  vpc_security_group_ids          = [aws_security_group.default.id]
  tags                            = var.tags
  copy_tags_to_snapshot           = true
  lifecycle {
    ignore_changes = [ master_password ]
  }
}

resource "aws_rds_cluster_instance" "default" {
  identifier                 = "${local.name_prefix}-default"
  cluster_identifier         = aws_rds_cluster.main.id
  instance_class             = var.instance_class
  engine                     = aws_rds_cluster.main.engine
  engine_version             = aws_rds_cluster.main.engine_version
  tags                       = var.tags
  auto_minor_version_upgrade = false
  publicly_accessible        = true
}