# Terraform configuration

variable profile {
  type = string
}

locals {
  region = "ap-southeast-1"
}

provider "aws" {
  region = local.region
  profile = var.profile
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_region = local.region
}

module "ssh_key" {
  source    = "./modules/ssh_key"
}

module "ec2" {
  source    = "./modules/ec2"
  vpc_id = module.vpc.id
  public_subnet_id = module.vpc.vpc_public_subnet.id
  key_name   = module.ssh_key.key_name
}