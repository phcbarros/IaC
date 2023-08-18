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