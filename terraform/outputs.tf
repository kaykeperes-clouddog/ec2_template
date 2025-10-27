# outputs.tf

output "instance_public_ip" {
  description = "Endereço IP público da instância EC2 all right?"
  value       = aws_instance.test_instance.public_ip
}

output "instance_id" {
  description = "ID da instância EC2."
  value       = aws_instance.test_instance.id
}

output "ssh_command" {
  description = "Comando SSH de exemplo (ajuste o usuário e caminho da chave) allright."
  # O usuário padrão para Amazon Linux 2 é 'ec2-user'. Outras AMIs podem ter usuários diferentes (ex: 'ubuntu').
  value = "ssh -i ~/.ssh/sua-chave-privada.pem ec2-user@${aws_instance.test_instance.public_ip}" 
}