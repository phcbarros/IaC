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
  availability_zones = ["${var.regiao_aws}a", "${var.regiao_aws}b"]
  name      = var.grupo_autoescala.nome
  max_size  = var.grupo_autoescala.maximo
  min_size  = var.grupo_autoescala.minimo

  launch_template {
    id = aws_launch_template.maquina.id
    version = "Latest"
  }

  target_group_arns = [ aws_lb_target_group.loadbalancer_target_group.arn ]
}

resource "aws_default_subnet" "subnet_1" {
  availability_zone = "${var.regiao_aws}a"
}

resource "aws_default_subnet" "subnet_2" {
  availability_zone = "${var.regiao_aws}b"
}

resource "aws_lb" "loadbalancer" {
  name               = "load-balancer"
  internal           = false
  subnets            = ["${aws_default_subnet.subnet_1.id}", "${aws_default_subnet.subnet_2.id}"]
}

resource "aws_lb_target_group" "loadbalancer_target_group" {
  name      = "loadbalancer-maquinas"
  port      = "8000"
  protocol  = "HTTP"
  vpc_id    = aws_default_vpc.default.id
}

resource "aws_lb_listener" "loadbalancer_listener" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = "8000"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.loadbalancer_target_group.arn
  }
}
resource "aws_default_vpc" "default" {
  
}