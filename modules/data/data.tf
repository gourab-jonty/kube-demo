#######
# VPC #
#######
data "aws_vpc" "vpc" {

  filter {
    name   = "tag:Name"
    values = ["${var.vpc_tag_name}"]
  }

}
data "aws_internet_gateway" "igw" {
  filter {
    name   = "tag:Name"
    values = ["igw"]
  }
}
data "aws_region" "region" {
  name = var.region
}
data "aws_availability_zones" "zones" {
}
##########
# SUBNET #
##########

data "aws_subnet" "subnet" {
  count             = length(data.aws_availability_zones.zones.names)
  availability_zone = data.aws_availability_zones.zones.names[count.index]
  filter {
    name   = "tag:Name"
    values = ["subnet-public-ap-south-1*"]
  }
}
#######
# AMI #
#######
data "aws_ami" "lin-ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}
