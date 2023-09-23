resource "aws_subnet" "sb_main_public_1a" {
  vpc_id                  = aws_vpc.vpc_main.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.tag}-sb-main-public-1a"
  }
}

resource "aws_subnet" "sb_main_private_1a" {
  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.tag}-sb-main-private-1a"
  }
}