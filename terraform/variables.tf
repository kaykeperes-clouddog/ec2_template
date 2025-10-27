# variables.tf

variable "aws_region" {
  description = "Região AWS onde a instância será criada."
  type        = string
  default     = "us-east-1" # Mude para sua região preferida
}

variable "instance_type" {
  description = "Tipo da instância EC2!"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "ID da AMI (Amazon Machine Image) para a instância EC2."
  type        = string
  # AMI para Amazon Linux 2 (gratuita) em us-east-1.
  # IMPORTANTE: Atualize este ID se você mudar a 'aws_region'.
  # Procure por "Amazon Linux 2 AMI" no console EC2 da sua região.
  default     = "ami-053b01d1872199b00" 
}

variable "key_pair_name" {
  description = "Nome do Key Pair (Par de Chaves) JÁ EXISTENTE na AWS EC2 para acesso SSH."
  type        = string
  # NÃO HÁ PADRÃO AQUI - VOCÊ PRECISA FORNECER O NOME!
  # Exemplo: "meu-par-de-chaves-aws"
}

variable "instance_name" {
  description = "Nome para a tag 'Name' da instância EC2."
  type        = string
  default     = "Workflow-Junior"
}