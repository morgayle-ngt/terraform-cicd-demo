provider "aws" {
    region = "us-east-1"
}

variable "cidr_blocks" {
    description = "CIDR blocks for VPC and Subnets"
    # default = "10.0.10.0/24"
    type = list(object({
        cidr_block = string
        name = string
    }))
}

variable avail_zone {}

# variable "vpc_cidr_block" {
#     description = "vpc cidr block"
# }

# variable "environment" {
#     description = "deployment environment"
# }

resource "aws_vpc" "development-vpc" {
    cidr_block = var.cidr_blocks[0].cidr_block
    tags = {
        Name: var.cidr_blocks[0].name
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.cidr_blocks[1].cidr_block
    availability_zone = var.avail_zone
    tags = {
        Name: var.cidr_blocks[1].name
    }
}

output "dev-vpc-id" {
    value = aws_vpc.development-vpc.id
}

output "dev-subnet-id" {
    value = aws_subnet.dev-subnet-1.id
}

# data "aws_vpc" "existing_vpc" {
#     default = true
# }

# resource "aws_subnet" "dev-subnet-2" {
#     vpc_id = data.aws_vpc.existing_vpc.id
#     cidr_block = "172.31.96.0/20"
#     availability_zone = "us-east-1a"
#     tags = {
#         Name: "subnet-2-default"
#     }
# }