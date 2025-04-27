# ========================================
# Project Settings
# ========================================
variable "project_name" {
  type        = string
  description = "Nome do projeto, usado para nomear os recursos AWS."
}

# variable "tags" {
#   type        = map(string)
#   description = "Mapa de tags padrão aplicadas a todos os recursos AWS."
# }

# ========================================
# Networking - VPC and Subnet
# ========================================
variable "vpc_cidr" {
  type        = string
  description = "Bloco CIDR para a criação da VPC."
}

variable "subnet_cidr" {
  type        = string
  description = "Bloco CIDR para a criação da Subnet dentro da VPC."
}

variable "availability_zone" {
  type        = string
  description = "Zona de disponibilidade AWS onde a Subnet será criada (ex: us-east-1a)."
}

# ========================================
# EC2 Instance
# ========================================
variable "ami_id" {
  type        = string
  description = "ID da imagem AMI usada para instanciar a EC2."
}

variable "instance_type" {
  type        = string
  description = "Tipo de instância EC2 (ex: t2.micro, t3.small)."
}

# ========================================
# Security Group
# ========================================
variable "description_sg" {
  type        = string
  description = "Descrição do Security Group (SG) que será criado."
}

variable "meu_ip" {
  type        = string
  description = "Seu IP público para permitir acesso na regra de segurança (ex: 1.2.3.4/32)."
}

# ========================================
# S3 Bucket
# ========================================

variable "nome_bucket" {
  type        = string
  description = "Nome do Bucket S3 que será criado. Deve ser único globalmente na AWS."
}

variable "usuarios" {
  type        = list(string)
  description = "Lista de usuários IAM que terão acesso total ao Bucket S3."
}
