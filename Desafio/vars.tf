variable "db" {
  type = map

  default = {
    db_name = "wordpress"
    username = "admin"
    password = "senhadowordpress"
  }
}

variable "tag" {
  type = string

  default = "labs-wordpress"  
}