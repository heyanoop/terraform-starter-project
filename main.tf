terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

}

module "subnet" {
  source = "./modules/subnet"
  vpc_id = module.vpc.vpc_id
  public_cidr = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  private_cidr = "10.0.1.0/24"
}

module "gateway" {
  source = "./modules/gateway"
  vpc_id = module.vpc.vpc_id
  private_subnet_id = module.subnet.private_subnet_id

}

module "route_table" {
    source = "./modules/route_tables"
    igw_id = module.gateway.igw_id
    vpc_id = module.vpc.vpc_id
    nat_gateway_id = module.gateway.nat_gateway_id

}

module "security_group" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "instance" {
  source = "./modules/ec2_instances"
  ami = "ami-09b0a86a2c84101e1"
  instance_type = "t3.micro"
  public_subnet_id = module.subnet.public_subnet_id
  private_subnet_id = module.subnet.private_subnet_id
  pem_key_name = "anoop-linux"
  bastion_security_group_ids = [module.security_group.private_instance_sg_id]
  private_security_group_ids = [module.security_group.private_instance_sg_id]
}

terraform {
  backend "s3" {
    bucket = "anoop-tf-test-bucket-2024"
    key    = "refined-terraform/terraform.tfstate"
    region = "ap-south-1"
  }
}