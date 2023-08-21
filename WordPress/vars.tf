variable "db" {
  type = map(any)

  default = {
    db_name  = "wordpress"
    username = "admin"
    password = "senhadowordpress"
  }
}

variable "tag" {
  type = string

  default = "labs-wordpress"
}

variable "key-pair-name" {
  type = string

  default = "labs-wordpress"
}

variable "security_group_id" {
  type = string

  default = "sg-0ae8496c3f25b6756"
}