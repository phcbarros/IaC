resource "aws_key_pair" "kp_ssh_access" {
  key_name   = var.key-pair-name
  public_key = file("${var.key-pair-name}.pub")
}

resource "aws_instance" "ec2_vpc_main_public" {
  ami                         = "ami-053b0d53c279acc90"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.kp_ssh_access.key_name
  subnet_id                   = aws_subnet.sb_main_public_1a.id
  security_groups             = [aws_security_group.sg_main_public.id]
  vpc_security_group_ids      = [aws_security_group.sg_main_public.id]
  associate_public_ip_address = true

  tags = {
    Name = "${var.tag}-ec2-public"
  }
}

resource "aws_instance" "ec2_vpc_main_private" {
  ami                         = "ami-053b0d53c279acc90"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.sb_main_private_1a.id
  security_groups             = [aws_security_group.sg_main_private.id]
  vpc_security_group_ids      = [aws_security_group.sg_main_private.id]
  key_name                    = aws_key_pair.kp_ssh_access.key_name
  associate_public_ip_address = false
  tags = {
    Name = "${var.tag}-ec2-private"
  }
}