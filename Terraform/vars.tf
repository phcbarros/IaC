variable "amis" {
  type = map

  default = {
    us-east-1 = "ami-0f34c5ae932e6f0e4"
    us-east-2 = "ami-02a89066c48741345"
  }
}

variable "instance_type" {
  default = "t2.micro"
}

variable "cdirs_acesso_remoto" {
  type = list
  default = [
    "/32",
  ]
}

variable "key_name" {
  default = "terraform-aws"
}