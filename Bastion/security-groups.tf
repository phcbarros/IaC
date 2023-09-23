# standalone rules
resource "aws_security_group" "sg_main_public" {
  name        = "SG Main Public"
  description = "Allow HTTP, HTTPS and SSH"
  vpc_id      = aws_vpc.vpc_main.id

  ingress {
    description = "Allow all incoming HTTPS IPv4 traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow all incoming HTTP IPv4 traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow all incoming SSH IPv4 traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"] # aberto para qualquer IP por questões de teste
  }

  ingress {
    description = "Allow all incoming ICMP IPv4 traffic"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description      = "Allow all IPv4 and IPv6 traffic"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
  }

  tags = {
    Name = "${var.tag}-sg-main-public"
  }
}

resource "aws_security_group" "sg_main_private" {
  name   = "SG Main Private"
  vpc_id = aws_vpc.vpc_main.id

  ingress {
    description = "Allow incoming SSH IPv4 traffic from the bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "Allow incoming ICMP IPv4 traffic from the bastion"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = [aws_security_group.sg_main_public]
}