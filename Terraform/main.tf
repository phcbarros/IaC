provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app_server" {
  count = 3
  ami           = "ami-0f34c5ae932e6f0e4"
  instance_type = "t2.micro"
  key_name = "iac-alura"
  tags = {
    Name = "dev-${count.index}"
  }

  vpc_security_group_ids = [""]
}

resource "aws_security_group" "acesso-ssh" {
  name        = "acesso-ssh"
  description = "acesso-ssh"
  #vpc_id      = aws_vpc.main.id

  ingress {
    description      = "Acesso SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [""]
    #ipv6_cidr_blocks = [""]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ssh"
  }
}