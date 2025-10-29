# Cria um Security Group simples para permitir SSH (MAIS RESTRITO)
resource "aws_security_group" "allow_ssh" {
  name        = "allow-ssh-simple-test"
  description = "Permite acesso SSH (porta 22) de IP específico" # Descrição Principal
  # Usa a VPC Padrão se 'vpc_id' não for especificado

  ingress {
    description = "Allow SSH from my IP" # Descrição da REGRA
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # IMPORTANTE: Substitua pelo seu IP público real!
    cidr_blocks = ["189.12.34.56/32"] 
  }

  # Bloco Egress Removido (usa o padrão Allow All)

  tags = {
    Name = "allow-ssh-simple-test-sg"
  }
}

# Cria uma IAM Role básica que a EC2 pode assumir
resource "aws_iam_role" "ec2_basic_role" {
  name = "ec2-basic-role-checkov-demo"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "ec2-basic-role-checkov-demo"
  }
}

# Cria o Instance Profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-profile-checkov-demo"
  role = aws_iam_role.ec2_basic_role.name
}

# Cria a instância EC2 (Corrigida)
resource "aws_instance" "test_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_pair_name
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id] 
  ebs_optimized               = true # CKV_AWS_135
  associate_public_ip_address = false # CKV_AWS_88 (Atenção: Remove acesso SSH direto)
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name # CKV2_AWS_41

  metadata_options { # CKV_AWS_79
    http_tokens   = "required" 
    http_endpoint = "enabled"  
  }

  tags = {
    Name = var.instance_name
  }
}