module "aws-dev" {
  source      = "../../infra"
  instancia   = "t2.micro"
  regiao_aws  = "us-east-1"
  chave       = "iac-dev"
  ami         = "ami-053b0d53c279acc90"
  grupo_de_seguranca = "desenvolvimento"
}

output "ip" {
  value = module.aws-dev.ip_publico
}