module "db" {
  source = "terraform-aws-modules/rds/aws"
  identifier = "${var.postgres_rds_identifier}"

  engine            = "${var.postgres_rds_engine}"
  engine_version    = "${var.postgres_rds_engine_version}"
  instance_class    = "${var.postgres_instance_class}"
  allocated_storage = 20
  storage_encrypted = false

  # kms_key_id        = "arm:aws:kms:<region>:<account id>:key/<kms key id>"
  name = "${var.postgres_rds_db_name}"
  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  username = "${var.postgres_rds_user}"

  password = "${var.postgres_rds_password}"
  port     = "5432"

  vpc_security_group_ids = ["${aws_security_group.postgres-sg.id}"]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # disable backups to create DB faster
  backup_retention_period = 0

  tags = {
    Environment = "assesment"
  }

  # DB subnet group
  subnet_ids = ["${aws_subnet.subnet1.id}","${aws_subnet.subnet2.id}"]

  # DB parameter group
  family = "${var.postgres_rds_parameter_group}"

  # Database Deletion Protection
  deletion_protection = false
  
}