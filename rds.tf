resource "aws_db_subnet_group" "subnet-rds" {
  name       = "subnet-rds"
  subnet_ids = ["${var.subnetA}", "${var.subnetB}", "${var.subnetC}"]
}

resource "aws_db_instance" "food_challenge" {
  db_name                      = "foodchallenge"
  engine                       = "postgres"
  engine_version               = "13.18"
  identifier                   = "rds-teste"
  username                     = "foodchallenge"
  password                     = "fiap2024"
  instance_class               = "db.t3.micro"
  storage_type                 = "gp3"
  allocated_storage            = 20
  max_allocated_storage        = 30
  multi_az                     = false
  vpc_security_group_ids       = ["${var.securityGroupId}"]
  db_subnet_group_name         = aws_db_subnet_group.subnet-rds.id
  apply_immediately            = true
  skip_final_snapshot          = true
  publicly_accessible          = false
  deletion_protection          = true
  performance_insights_enabled = true
#  backup_retention_period      = 1
#  backup_window                = "00:00-00:30"
#  copy_tags_to_snapshot        = true
#  delete_automated_backups     = true
  tags = {
    Name = "rds"
  }
}
