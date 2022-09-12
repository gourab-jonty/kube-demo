resource "aws_eip" "nat_eip-1" {
  vpc = true
}
resource "aws_nat_gateway" "nat-1" {
  allocation_id = aws_eip.nat_eip-1.id
  subnet_id     = var.public_subnet_b
}
resource "aws_subnet" "private_subnet-1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_b_cidr
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "subnet-private-ap-south-1b"
  }
}
resource "aws_route_table" "private-1" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name}-private-route-table"
  }
}
resource "aws_route" "private_nat_gateway-1" {
  route_table_id         = aws_route_table.private-1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-1.id
}
resource "aws_route_table_association" "private-1" {
  subnet_id      = aws_subnet.private_subnet-1.id
  route_table_id = aws_route_table.private-1.id
}





resource "aws_eip" "nat_eip-2" {
  vpc = true
}
resource "aws_nat_gateway" "nat-2" {
  allocation_id = aws_eip.nat_eip-2.id
  subnet_id     = var.public_subnet_a
}
resource "aws_subnet" "private_subnet-2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_a_cidr
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "subnet-private-ap-south-1a"
  }
}
resource "aws_route_table" "private-2" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name}-private-route-table"
  }
}
resource "aws_route" "private_nat_gateway-2" {
  route_table_id         = aws_route_table.private-2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-2.id
}
resource "aws_route_table_association" "private-2" {
  subnet_id      = aws_subnet.private_subnet-2.id
  route_table_id = aws_route_table.private-2.id
}