resource "aws_db_parameter_group" "rds-pg" {
  name   = "${var.name}-rds-pg"
  family = "mysql8.0"

}


resource "aws_db_subnet_group" "subnet_group" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids
}

data "aws_ssm_parameter" "pwd" {
  name = var.parameter_name
}



resource "aws_db_instance" "sqlserver" {
  allocated_storage      = var.storage
  instance_class         = var.instance_class
  identifier             = "${var.name}-rds"
  username               = "admin"
  password               = data.aws_ssm_parameter.pwd.value
  engine                 = var.engine
  port                   = 3306
  engine_version         = var.engine_version
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.id
  vpc_security_group_ids = var.rds_sg
  parameter_group_name   = aws_db_parameter_group.rds-pg.id
  maintenance_window     = var.maintenance_window
  multi_az               = false
  skip_final_snapshot    = true
  copy_tags_to_snapshot  = true
}

