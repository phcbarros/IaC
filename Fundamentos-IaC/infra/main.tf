terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.regiao_aws
}

resource "aws_instance" "app_server" {
  ami           = var.ami
  instance_type = var.instancia
  key_name      = var.chave
  # user_data     = "${file("init.sh")}"
  # user_data_replace_on_change = true

  tags = {
    Name = "Terraform Ansible Python"
  }
}

output "app_server_ip" {
  value = aws_instance.app_server.public_ip
}

resource "aws_key_pair" "chave_ssh" {
  key_name    = var.chave
  public_key  = file("${var.chave}.pub")

  tags = {
    Alura = "curso-iac"
  }
}

output "ip_publico" {
  value = aws_instance.app_server.public_ip
}