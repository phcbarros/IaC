resource "aws_eip" "eip_nat_main_1a" {
  domain = "vpc"

  tags = {
    Name = "${var.tag}-eip-nat-main-1a"
  }
}

resource "aws_nat_gateway" "nat_main_1a" {
  allocation_id = aws_eip.eip_nat_main_1a.id
  subnet_id     = aws_subnet.sb_main_public_1a.id # public subnet

  tags = {
    Name = "${var.tag}-nat-main-1a"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw_main_1a]
}