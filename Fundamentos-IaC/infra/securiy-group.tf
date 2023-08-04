resource "aws_security_group" "acesso_geral" {
  name        = var.grupo_de_seguranca
  description = "Grupo de Seguranca"
  #vpc_id      = aws_vpc.main.id

  # protocolos, portas e ips permitidos
  ingress {
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
  }

  egress {
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
  }
  
  tags = {
    Name = "acesso-geral"
  }
}