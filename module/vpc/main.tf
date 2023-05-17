# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = local.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge( {
    Name = local.name
  }, local.tags)
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(local.private_subnets_cidr_block)
  cidr_block              = element(local.private_subnets_cidr_block, count.index)
  availability_zone       = element(local.availability_zones, count.index)
  map_public_ip_on_launch = false
  tags                    = merge({
    Name = "${local.name} Private Subnet ${element(var.availability_zones, count.index)}"
  }, local.tags)
}

# Routing tables to route traffic for Private Subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = merge({
    Name = "${local.name} Private Route Table"
  }, local.tags)
}

# Route table associations for Private Subnets
resource "aws_route_table_association" "private" {
  count          = length(local.private_subnets_cidr_block)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

# Default Security Group of VPC
resource "aws_security_group" "security_group" {
  name        = "${local.name} Security Group"
  description = "Default SG to allow traffic from the VPC"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [
    aws_vpc.vpc
  ]

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }

  tags = merge({}, local.tags)
}