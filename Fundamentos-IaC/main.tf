terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name      = "iac-alura"
  # user_data     = "${file("init.sh")}"
  # user_data_replace_on_change = true

  tags = {
    Name = "Teste AWS"
  }
}

output "app_server_ip" {
  value = aws_instance.app_server.public_ip
}