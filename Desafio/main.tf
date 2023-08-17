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
  count = 0

  tags = {
    Name = var.tag
  }
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
    ENV = var.tag
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
    ENV = var.tag
  }
}

resource "aws_default_vpc" "default" {
}

resource "aws_key_pair" "acesso-ssh" {
  key_name = "labs-wordpress"
  public_key = file("labs-wordpress.pub") # criar chave
}

resource "aws_instance" "web" {
  ami           = "ami-08a52ddb321b32a8c"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_default_vpc.default.id}", "${aws_security_group.acesso-ssh2.id}", "${aws_security_group.acesso-web2.id}"] # como associar o grupo default?
  key_name = aws_key_pair.acesso-ssh.key_name
  user_data = filebase64("amazon-apache.sh")

  tags = {
    Name = var.tag
  }
}