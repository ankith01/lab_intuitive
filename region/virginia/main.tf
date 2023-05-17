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

module "lab_s3bucket" {
  source        = "../../module/S3"
  bucket = "lab1-s3-new-aws"
}

 module "lab_server1" {
  source        = "../../module/EC2"
  name = "Lab_server"
  ami                = "ami-0889a44b331db0194"
  instance_type               = "t3.small" 
  subnet_id                   = module.vpc.private_subnets_id
  vpc_security_group_ids      = module.vpc.security_groups_ids

  enable_volume_tags = false
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 10
      tags = {
        Name = "my-root-block"
      }
    },
  ]

  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_type = "gp3"
      volume_size = 5
      encrypted   = true
      tags = {
        MountPoint = "/mnt/data"
      }
    }
  ]
  tags = local.tags
}
