terraform {
   backend "s3" {
    bucket         = "cc-tf-state-backend-ci-cd-demo023"
    key            = "+KpEulAgX9HdXMZlwP+W+2tvpg/nQmWGfVlmuUdJ"
    region         = "us-east-1"
  }
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

module "tf-state" {
  source      = "./modules/tf-state"
  bucket_name = "cc-tf-state-backend-ci-cd-demo023"
}

module "vpc-infra" {
  source = "./modules/vpc"

  # VPC Input Vars
  vpc_cidr             = local.vpc_cidr
  availability_zones   = local.availability_zones
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
}
