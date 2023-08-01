provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "us-east-2"
  region = "us-east-2"
}

resource "aws_instance" "dev" {
  count         = 3
  ami           = var.amis["us-east-1"]
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name = "dev${count.index}"
  }

  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

resource "aws_instance" "dev5" {
  ami           = var.amis["us-east-1"]
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name = "dev5"
  }

  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

resource "aws_instance" "dev6" {
  # aws+nome_do_alias
  provider      = aws.us-east-2
  ami           = var.amis["us-east-2"]
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name = "dev6"
  }

  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"]
  depends_on = [aws_dynamodb_table.dynamodb-hml]
}

resource "aws_instance" "dev7" {
  # aws+nome_do_alias
  provider      = aws.us-east-2
  ami           = var.amis["us-east-2"]
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name = "dev7"
  }

  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"]
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

resource "aws_s3_bucket" "bucket-homolog" {
  bucket = "phlabs-homolog"

  tags = {
    Name        = "labs-homolog"
  }
}

resource "aws_s3_bucket_ownership_controls" "homolog" {
  bucket = aws_s3_bucket.bucket-homolog.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "homolog" {
  depends_on = [aws_s3_bucket_ownership_controls.homolog]

  bucket = aws_s3_bucket.bucket-homolog.id
  acl    = "private"
}