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
  project_name       = "logitest"
  tags               = local.tags  
}

module "ec2_instance" {
  source = "git::https://github.com/eriknathan/terraform-modules.git//modules/ec2-instance?ref=main"

  ami_id             = "ami-084568db4383264d4"
  instance_type      = "t2.micro"
  subnet_id          = module.vpc.subnet_id
  project_name       = "logitest"
  disk_size          = 40
  tags               = local.tags  
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