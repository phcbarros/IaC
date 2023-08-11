variable "db" {
  type = map

  default = {
    db_name = "wordpress"
    username = "admin"
    password = "senhadowordpress"
  }
}