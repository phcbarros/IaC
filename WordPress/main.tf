terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.11"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "db_wordpress" {
  allocated_storage = 10
  db_name           = var.db["db_name"]
  engine            = "mysql"
  engine_version    = "8.0.33"
  instance_class    = "db.t3.micro"
  username          = var.db["username"]
  password          = var.db["password"]
  #parameter_group_name = "default.mysql8.0.33"
  port                = 3306
  skip_final_snapshot = true
  count               = 1

  tags = {
    Name = var.tag
  }
}

output "database_address" {
  value = aws_db_instance.db_wordpress[0].address
}

data "aws_vpc" "default" {
  default = true
}

# Adding security group rules

data "aws_security_group" "selected" {
  id = var.security_group_id
}

# inline rules
resource "aws_security_group" "sg_allow_ssh_2" {
  name        = "sg_allow_ssh_2"
  description = "Allow SSH 2"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["200.158.31.77/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    ENV = var.tag
  }
}

# standalone rules
resource "aws_security_group" "sg_allow_http_and_https" {
  name        = "sg_allow_http_and_https"
  description = "Allow HTTP e HTTPS to web server"
  vpc_id      = data.aws_vpc.default.id

  ingress = []
  egress  = []

  tags = {
    ENV = var.tag
  }
}

resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  description       = "HTTPS ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_allow_http_and_https.id
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  description       = "HTTP ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_allow_http_and_https.id
}

resource "aws_key_pair" "kp_ssh_access" {
  key_name   = var.key-pair-name
  public_key = file("${var.key-pair-name}.pub")
}

resource "aws_instance" "site_wordpress" {
  ami             = "ami-053b0d53c279acc90"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.kp_ssh_access.key_name
  user_data       = filebase64("ubuntu-apache.sh")
  security_groups = [aws_security_group.sg_allow_ssh_2.name, aws_security_group.sg_allow_http_and_https.name, data.aws_security_group.selected.name]

  tags = {
    Name = var.tag
  }
}

output "ip_publico_wordpress" {
  value = aws_instance.site_wordpress.public_ip
}