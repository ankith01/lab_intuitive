provider "aws" {
  region = local.region
}

data "terraform_remote_state" "lab_state" {
  backend = "s3"
  config = {
    bucket  = "terraform1-state-us-east-1"
    key     = "terraform/backend.tfstate"
    region = "us-east-1"
  }
}

/* locals {
  subnet-id = data.terraform_remote_state.lab_state.outputs.private_subnets_id
} */

module "vpc" {
  source                     = "../../module/vpc"
  name                       = "VPC"
  availability_zones         = local.availability_zones
  vpc_cidr_block             = "10.0.0.0/16"
  private_subnets_cidr_block = ["10.0.0.0/19"]
  vpc_tags                   = local.tags
}