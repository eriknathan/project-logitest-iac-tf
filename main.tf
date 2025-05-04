module "vpc" {
  source = "git::https://github.com/eriknathan/terraform-modules.git//modules/vpc?ref=main"

  vpc_cidr          = var.vpc_cidr
  subnet_cidr       = var.subnet_cidr
  availability_zone = var.availability_zone
  project_name      = var.project_name
  tags              = local.tags
}

module "ec2_instance" {
  source = "git::https://github.com/eriknathan/terraform-modules.git//modules/ec2-instance?ref=main"

  ami_id             = var.ami_id
  instance_type      = var.instance_type
  subnet_id          = module.vpc.subnet_id
  project_name       = var.project_name
  disk_size          = var.disk_size
  security_group_ids = [module.sg.security_group_id]
  tags               = local.tags
}

module "sg" {
  source = "git::https://github.com/eriknathan/terraform-modules.git//modules/security-group?ref=main"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  description  = var.description_sg
  tags         = local.tags

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["${var.meu_ip}"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "bucket" {
  source       = "git::https://github.com/eriknathan/terraform-modules.git//modules/s3-bucket?ref=main"

  project_name = var.project_name
  bucket_name  = var.bucket_name
  tags         = local.tags
}

module "iam-bucket" {
  source       = "git::https://github.com/eriknathan/terraform-modules.git//modules/iam-bucket-access?ref=main"

  project_name = var.project_name
  for_each     = toset(var.usuarios)
  user_name    = each.value
  bucket_arn   = module.bucket.bucket_arn
  tags         = local.tags
}

# --------------------------------------------------------------------------------


