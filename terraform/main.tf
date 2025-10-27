# Cria um Security Group simples para permitir SSH
resource "aws_security_group" "allow_ssh" {
  name        = "allow-teste"
  description = "Permite acesso SSH (porta 22) de qualquer lugar"
  # Usa a VPC Padrão se 'vpc_id' não for especificado

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # ATENÇÃO: Permite SSH de qualquer IP!
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh-simple-test-sg"
  }
}

# Cria a instância EC2
resource "aws_instance" "test_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name # Usa o nome do Key Pair existente
  
  # Usa o Security Group criado acima
  vpc_security_group_ids = [aws_security_group.allow_ssh.id] 
  
  # Garante que a instância tenha um IP público na VPC padrão
  associate_public_ip_address = true 

  tags = {
    Name = var.instance_name
  }
}