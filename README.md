<h1 align="center">🚀 Projeto Logitest</h1>

Este repositório contém a infraestrutura como código (IaC) do projeto **Logitest**, cujo objetivo é provisionar uma arquitetura robusta e reutilizável na AWS utilizando **módulos remotos do Terraform**, além de automatizar todo o processo de deploy através do **GitHub Actions**.

## 📦 Visão Geral

O projeto Logitest foi criado com foco em reutilização, organização e automação. Todos os recursos são provisionados exclusivamente por **módulos armazenados em um repositório central de módulos Terraform**, localizado [aqui](https://github.com/eriknathan/terraform-modules).

Além disso, o deploy e gerenciamento do ciclo de vida da infraestrutura é feito de forma automática via **GitHub Actions**, garantindo rastreabilidade e consistência nos ambientes.

## 🏗️ Arquitetura

A infraestrutura provisionada contempla os seguintes recursos principais:

- **VPC (Virtual Private Cloud):** rede isolada com CIDR customizável e sub-rede pública.
- **Security Group:** controla o acesso à instância EC2, com liberação das portas 22 (SSH) e 80 (HTTP).
- **Instância EC2:** máquina virtual configurada com AMI, tipo de instância e disco definidos por variáveis.
- **Bucket S3:** utilizado para armazenar objetos no padrão AWS S3.
- **Políticas IAM para o bucket:** usuários definidos têm acesso controlado ao bucket via políticas específicas.

## 🧩 Módulos Utilizados

Todos os módulos abaixo são consumidos diretamente do repositório:

- `vpc`: cria VPC e sub-rede
- `security-group`: configura regras de segurança (ingress)
- `ec2-instance`: instancia uma máquina EC2 na sub-rede criada
- `s3-bucket`: provisiona um bucket S3
- `iam-bucket-access`: cria permissões de acesso ao bucket para múltiplos usuários

Fonte dos módulos: [github.com/eriknathan/terraform-modules](https://github.com/eriknathan/terraform-modules)

## ⚙️ Variáveis

Você deve configurar as variáveis no seu arquivo `terraform.tfvars` ou via pipeline:

```hcl
project_name       = "logitest"
vpc_cidr           = "10.0.0.0/16"
subnet_cidr        = "10.0.1.0/24"
availability_zone  = "us-east-1a"
instance_type      = "t3.micro"
ami_id             = "ami-xxxxxxxx"
disk_size          = 10
bucket_name        = "logitest-bucket"
usuarios           = ["user1", "user2"]
description_sg     = "SG do projeto logitest"
meu_ip             = "SEU_IP_COM_REDE/32"
```

## 🔁 Deploy Automático com GitHub Actions

Toda a automação é feita via GitHub Actions, por meio de uma pipeline definida no repositório. A pipeline:

1. Faz o checkout do código
2. Configura credenciais AWS via OIDC
3. Inicializa e valida o Terraform
4. Executa plan, apply ou destroy baseado na configuração definida em destroy.json

## ✅ Pré-requisitos

- Terraform >= 1.8
- Conta AWS com permissões para provisionamento
- GitHub Actions configurado com OIDC para assumir roles na AWS

## 📂 Estrutura do Projeto

```
.
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── destroy.json
└── .github/
    └── workflows/
        └── terraform.yml
```
