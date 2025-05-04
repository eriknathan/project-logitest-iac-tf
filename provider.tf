provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "s3-erik-tf"
    key    = "logitest/terraform.tfstate"
    region = "us-east-1"
  }
}