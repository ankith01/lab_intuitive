locals {
  region             = "us-east-1"
  availability_zones = ["${local.region}a"]
  tags               = {
    "Environment" : "Lab-Test"
    "Project" : "Infrastructure"
  }
}