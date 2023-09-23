resource "aws_route_table" "rtb_main_public_1a" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_main_1a.id
  }

  tags = {
    Name = "${var.tag}-rtb-main-public-1a"
  }
}

resource "aws_route_table" "rtb_main_private_1a" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_main_1a.id
  }

  tags = {
    Name = "${var.tag}-rtb-main-private-1a"
  }
}

resource "aws_route_table_association" "rtba_main_public_1a" {
  subnet_id      = aws_subnet.sb_main_public_1a.id
  route_table_id = aws_route_table.rtb_main_public_1a.id
}

resource "aws_route_table_association" "rtba_main_private_1a" {
  subnet_id      = aws_subnet.sb_main_private_1a.id
  route_table_id = aws_route_table.rtb_main_private_1a.id
}