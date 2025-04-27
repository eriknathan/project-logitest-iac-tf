# ========================================
# Project Settings
# ========================================
project_name = "epiteto"
regiao       = "us-east-1"

# ========================================
# Networking - VPC and Subnet
# ========================================
vpc_cidr          = "10.1.0.0/16"
subnet_cidr       = "10.1.1.0/24"
availability_zone = "us-east-1a"

# ========================================
# EC2 Instance
# ========================================
ami_id        = "ami-084568db4383264d4"
instance_type = "t2.micro"

# ========================================
# Security Group
# ========================================
description_sg = "Permitir acesso SSH e HTTP"
meu_ip         = "201.182.93.251/32"

# ========================================
# S3 Bucket
# ========================================
nome_bucket = "meu-bucket-exemplo"
usuarios    = [
  "eriknathan"
]
