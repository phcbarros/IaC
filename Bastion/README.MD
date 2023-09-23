# Bastion Host

## Objetivo

- Configurar uma rede `(VPC)` com uma sub-rede `privada` e uma sub-rede `pública`.
- Configurar um `Internet Gateway` à sub-rede pública.
- Configurar um `NAT Gateway` na sub-rede privada.
- Criar duas instâncias `(EC2)`, uma com acesso público e outra com acesso privado.
- Criar um grupo de segurança `(Security Group)` público para permitir acesso SSH (porta 22), HTTP (porta 80) e HTTPS (porta 443).
- Associar o grupo de segurança público à instância pública.
- Criar um grupo de segurança (Security Group) privado para permitir acesso SSH (porta 22) apenas para IPs dentro da sub-rede pública.
- Associar o grupo de segurança privado à instância privada.


![alt text](./bastion.png "bastion arquitetura" )


## Requisitos

- Ter uma conta na AWS
- Ter o Terraform instalado
- Gerar uma chave SSH

```shell
# gerar SSH
ssh-keygen -f iac-prd -t rsa
``````

## Referências

[O que é um Bastion Host - Alura+](https://www.youtube.com/watch?v=PNjBp5R98Lk)
[Harrison Lima](https://github.com/harrisonmlima/2ec2/tree/master)