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
}