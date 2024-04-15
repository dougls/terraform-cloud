#resource "aws_db_instance" "food_challenge" {
#  allocated_storage      = 10
#  db_name                = "foodchallenge"
#  engine                 = "postgresql"
#  instance_class         = "db.t3.micro"
#  identifier             = "rds"
#  username               = "foodchallenge"
#  password               = "root1234"
#  skip_final_snapshot    = true
#  vpc_security_group_ids = [var.securityGroupId]
#  tags = {
#    Name = "rds"
#  }
#}

resource "aws_db_instance" "food_challenge" {
  db_name                      = "foodchallenge"
  engine                       = "postgresql"
  engine_version               = "13.10"
  identifier                   = "rds"
  username                     = "foodchallenge"
  password                     = "root1234"
  instance_class               = "db.t3.micro"
  storage_type                 = var.storageType
  allocated_storage            = 10
#  max_allocated_storage        = var.maxStorage
  multi_az                     = false
  vpc_security_group_ids       = [var.securityGroupId]
  db_subnet_group_name         = ["subnet-07602af85b7b1c946", "subnet-00c83d7f026e8b29c", "subnet-09270b32bae1426ff"]
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
