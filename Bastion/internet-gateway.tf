resource "aws_internet_gateway" "igw_main_1a" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "${var.tag}-igw-main-1a"
  }
}