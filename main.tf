provider "aws" {
  region  = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "terraformversionupgrade"
    key = "terraform-updated/terraform.tfstate"
    region = "ap-south-1"
  }
}

module "vpc" {
  source      = "git@github.com:prakashjha08/vpc-module.git?ref=terraform-update"
  # source = "./vpc"
  vpc_cidr    = "10.0.0.0/16"
  subnet_cidr = ["10.0.0.0/20", "10.0.16.0/20"]
  sg_name     = "tf-upgrade"
  ingress_rules = {
    "tcp,443,443" = "10.0.0.0/20,10.0.16.0/20"
    "tcp,1,65535" = "10.0.32.0/20,10.0.48.0/20"
    "tcp,80,80"   = "10.0.64.0/20,10.0.80.0/20"
  }
}
