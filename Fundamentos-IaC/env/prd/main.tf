module "aws-prd" {
  source      = "../../infra"
  instancia   = "t2.micro"
  regiao_aws  = "us-east-2"
  chave = "iac-prd"
  ami = "ami-024e6efaf93d85776"
}

output "ip" {
  value = module.aws-prd.ip_publico
}