variable "regiao_aws" {
  type    = string
}

variable "chave" {
  type = string
}

variable "instancia" {
  type = string
}

variable "ami" {
  type = string
}

variable "grupo_de_seguranca" {
  type = string
}

variable "grupo_autoescala" {
  type = object({
    nome = string
    maximo = number
    minimo = number
  })
}

variable "producao" {
  type = bool
}