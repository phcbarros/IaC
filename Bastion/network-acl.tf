resource "aws_network_acl" "acl_main_public" {
  vpc_id = aws_vpc.vpc_main.id
  subnet_ids = [aws_subnet.sb_main_public_1a.id]
 
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 150
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol    = "icmp"
    rule_no     = 160
    action      = "allow"
    cidr_block  = "0.0.0.0/0"
    icmp_type   = -1
    icmp_code = -1
    from_port   = 8
    to_port     = 0
  }

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  egress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  egress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  egress {
    protocol   = "tcp"
    rule_no    = 130
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 53
    to_port    = 53
  }

  egress {
    protocol   = "tcp"
    rule_no    = 150
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  egress {
    protocol    = "icmp"
    rule_no     = 160
    action      = "allow"
    cidr_block  = "0.0.0.0/0"
    icmp_type   = -1
    icmp_code = -1
    from_port   = 8
    to_port     = 0
  }
  
  tags = {
    Name = "${var.tag}-acl-private-public"
  }
}

resource "aws_network_acl" "acl_main_private" {
  vpc_id = aws_vpc.vpc_main.id
  subnet_ids = [aws_subnet.sb_main_private_1a.id]
  
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.0.0.0/16"
    from_port  = 27017
    to_port    = 27017
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "10.0.0.0/16"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  ingress {
    protocol    = "icmp"
    rule_no     = 130
    action      = "allow"
    cidr_block  = "10.0.0.0/16"
    icmp_type   = -1
    icmp_code = -1
    from_port   = 8
    to_port     = 0
  }
  
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  egress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  egress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }
  
  egress {
    protocol    = "icmp"
    rule_no     = 130
    action      = "allow"
    cidr_block  = "10.0.0.0/16"
    icmp_type   = -1
    icmp_code = -1
    from_port   = 8
    to_port     = 0
  }

  tags = {
    Name = "${var.tag}-acl-main-private"
  }
}