resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0.25"
  instance_class       = "db.t3.micro"
  name                 = "mydatabase"
  username             = "admin"
  password             = var.rds_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  # Ensure the RDS instance is deployed in the same VPC and subnet as your EC2 instances
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}

resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Security group for RDS instance"

  # Inbound rule for MySQL (port 3306)
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Replace with specific CIDR blocks for better security
  }

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "rds_endpoint" {
  value = aws_db_instance.default.endpoint
}

output "rds_port" {
  value = aws_db_instance.default.port
}

output "rds_username" {
  value = aws_db_instance.default.username
}

output "rds_db_name" {
  value = aws_db_instance.default.name
}
