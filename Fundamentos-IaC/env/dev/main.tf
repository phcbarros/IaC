module "aws-dev" {
  source      = "../../infra"
  instancia   = "t2.micro"
  regiao_aws  = "us-east-1"
  chave       = "iac-dev"
  ami         = "ami-053b0d53c279acc90"
  grupo_de_seguranca = "desenvolvimento"
  grupo_autoescala = {
    nome = "ga-desenvolvimento"
    minimo = 0
    maximo = 1
  }
}

# output "ip" {
#   value = module.aws-dev.ip_publico
# }