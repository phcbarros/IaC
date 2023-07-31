provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "us-east-2"
  region = "us-east-2"
}

resource "aws_instance" "dev" {
  count = 3
  ami           = "ami-0f34c5ae932e6f0e4"
  instance_type = "t2.micro"
  key_name = "terraform-aws"
  tags = {
    Name = "dev-${count.index}"
  }

  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

resource "aws_instance" "dev4" {
  ami           = "ami-0f34c5ae932e6f0e4"
  instance_type = "t2.micro"
  key_name = "terraform-aws"
  tags = {
    Name = "dev4"
  }

  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
  depends_on = [ aws_instance.dev4 ]
}

resource "aws_instance" "dev5" {
  ami           = "ami-0f34c5ae932e6f0e4"
  instance_type = "t2.micro"
  key_name = "terraform-aws"
  tags = {
    Name = "dev5"
  }

  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

resource "aws_instance" "dev6" {
  # aws+nome_do_alias
  provider = aws.us-east-2
  ami           = "ami-02a89066c48741345"
  instance_type = "t2.micro"
  key_name = "terraform-aws"
  tags = {
    Name = "dev6"
  }

  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"]
  depends_on = [aws_dynamodb_table.dynamodb-hml]
}

resource "aws_s3_bucket" "bucket-dev4" {
  bucket = "phlabs-dev4"

  tags = {
    Name        = "labs-dev4"
  }
}

resource "aws_s3_bucket_ownership_controls" "dev4" {
  bucket = aws_s3_bucket.bucket-dev4.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "dev4" {
  depends_on = [aws_s3_bucket_ownership_controls.dev4]

  bucket = aws_s3_bucket.bucket-dev4.id
  acl    = "private"
}

resource "aws_dynamodb_table" "dynamodb-hml" {
  provider       = aws.us-east-2
  name           = "GameScores"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }

  attribute {
    name = "TopScore"
    type = "N"
  }

  global_secondary_index {
    name               = "GameTitleIndex"
    hash_key           = "GameTitle"
    range_key          = "TopScore"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["UserId"]
  }

  tags = {
    Name        = "dynamodb-hml"
    Environment = "homolog"
  }

}