provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "wordpress" {
  allocated_storage    = 10
  db_name              = var.db["db_name"]
  engine               = "mysql"
  engine_version       = "8.0.33"
  instance_class       = "db.t3.micro"
  username             = var.db["username"]
  password             = var.db["password"]
  parameter_group_name = "default.mysql8.0.33"
  port                 =  3306
}

resource "aws_security_group" "acesso-ssh2" {
  name = "acesso-ssh2"
  description = "Acesso SSH 2"

  ingress {
    description      = "Acesso SSH 2"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["200.158.31.77/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    ENV = "labs"
  }
}

resource "aws_security_group" "acesso-web2" {
  name = "acesso-web2"
  description = "Acesso WEB"

  ingress {
    description      = "Acesso WEB 2"
    from_port        = 80
    to_port          = 443
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    ENV = "labs"
  }
}