
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Use a versão mais recente e estável do provedor AWS
    }
  }
}

# Configura o provedor AWS
provider "aws" {
  region = var.aws_region # Pega a região da variável 'aws_region'
}