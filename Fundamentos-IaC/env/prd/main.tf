module "aws-prd" {
  source      = "../../infra"
  instancia   = "t2.micro"
  regiao_aws  = "us-east-1"
  chave       = "iac-prd"
  ami         = "ami-053b0d53c279acc90"
  grupo_de_seguranca = "producao"
  grupo_autoescala = {
    nome = "ga-producao"
    minimo = 1
    maximo = 10
  }
  producao = true
}

# output "ip" {
#   value = module.aws-prd.ip_publico
# }