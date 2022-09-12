output "vpc_id" {
  value = data.aws_vpc.vpc.id
}
output "vpc_cidr" {
  value = data.aws_vpc.vpc.cidr_block
}
output "region" {
  value = data.aws_region.region.name
}
output "subnet-a" {
  value = data.aws_subnet.subnet[0].id
}
output "subnet-b" {
  value = data.aws_subnet.subnet[1].id
}
output "subnet-c" {
  value = data.aws_subnet.subnet[2].id
}
output "lin-ami" {
  value = data.aws_ami.lin-ami.id
}
output "igw-id" {
  value = data.aws_internet_gateway.igw.id
}
