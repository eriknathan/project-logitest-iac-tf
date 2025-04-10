provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "s3-erik-tf"
    key    = "logiteste/terraform.tfstate"
    region = "us-east-1"
  }
}

# --------------------------------------------------------------------------------

module "vpc" {
  source = "git::https://github.com/eriknathan/terraform-modules.git//modules/vpc?ref=main"

  vpc_cidr          = "10.1.0.0/16"
  subnet_cidr       = "10.1.1.0/24"
  availability_zone = "us-east-1a"
  project_name      = "logitest"
  tags              = local.tags
}

module "ec2_instance" {
  source = "git::https://github.com/eriknathan/terraform-modules.git//modules/ec2-instance?ref=main"

  ami_id             = "ami-084568db4383264d4"
  instance_type      = "t2.micro"
  subnet_id          = module.vpc.subnet_id
  project_name       = "logitest"
  disk_size          = 40
  security_group_ids = [module.sg.security_group_id]
  tags               = local.tags
}


module "sg" {
  source       = "git::https://github.com/eriknathan/terraform-modules.git//modules/security-group?ref=main"
  project_name = "logitest"
  vpc_id       = module.vpc.vpc_id
  description  = "Permitir acesso SSH e HTTP"
  tags         = local.tags

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["201.71.62.130/32"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

# --------------------------------------------------------------------------------

locals {
  tags = {
    Departament  = "DevOps"
    Organization = "Infrastructure and Operations"
    Project      = "logitest"
    Enviroment   = "Development"
    Author       = "Erik Nathan"
  }
}