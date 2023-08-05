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

resource "aws_launch_template" "maquina" {
  image_id = var.ami
  instance_type = var.instancia
  key_name      = var.chave
  # user_data     = "${file("init.sh")}"
  # user_data_replace_on_change = true

  tags = {
    Name = "Terraform Ansible Python"
  }

  security_group_names = [var.grupo_de_seguranca]
  user_data = filebase64("ansible.sh")
}

resource "aws_key_pair" "chave_ssh" {
  key_name    = var.chave
  public_key  = file("${var.chave}.pub")

  tags = {
    Alura = "curso-iac"
  }
}

# output "ip_publico" {
#   value = aws_instance.app_server.public_ip
# }

resource "aws_autoscaling_group" "grupo_autoescala" {
  availability_zones = ["${var.regiao_aws}a"]
  name      = var.grupo_autoescala.nome
  max_size  = var.grupo_autoescala.maximo
  min_size  = var.grupo_autoescala.minimo

  launch_template {
    id = aws_launch_template.maquina.id
    version = "Latest"
  }
}