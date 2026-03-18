resource "aws_db_subnet_group" "main" {
  name       = "${var.project}-db-subnet-group"
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]

  tags = { Name = "${var.project}-db-subnet-group" }
}

resource "aws_db_instance" "main" {
  engine             = "postgres"
  engine_version     = "15"
  instance_class     = "db.t3.micro"
  allocated_storage  = 20

  db_name  = "app_production"
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  skip_final_snapshot = true
  publicly_accessible = false
  multi_az            = false

  tags = { Name = "${var.project}-db" }
}
