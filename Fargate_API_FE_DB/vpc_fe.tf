resource "aws_vpc" "fe" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    App  = var.name_fe
    Name = "vpc"
  }
}

resource "aws_route_table" "public_fe" {
  vpc_id = aws_vpc.fe.id

  tags = {
    App  = var.name_fe
    Name = "route-table-public"
  }
}

resource "aws_route_table" "private_fe" {
  vpc_id = aws_vpc.fe.id

  tags = {
    App  = var.name_fe
    Name = "route-table-private"
  }
}

resource "aws_route_table_association" "public_subnet_fe" {
  subnet_id      = aws_subnet.public_fe.id
  route_table_id = aws_route_table.public_fe.id
}

resource "aws_route_table_association" "private_subnet_fe" {
  subnet_id      = aws_subnet.private_fe.id
  route_table_id = aws_route_table.private_fe.id
}

resource "aws_eip" "nat_ip_fe" {
  depends_on = [aws_internet_gateway.igw_fe]
  domain = "vpc"
}

resource "aws_internet_gateway" "igw_fe" {
  vpc_id = aws_vpc.fe.id

  tags = {
    App  = var.name_fe
    Name = "igw"
  }
}

resource "aws_nat_gateway" "ngw_fe" {
  subnet_id     = aws_subnet.public_fe.id
  allocation_id = aws_eip.nat_ip_fe.id

  tags = {
    App  = var.name_fe
    Name = "ngw"
  }
}

resource "aws_route" "public_igw_fe" {
  route_table_id         = aws_route_table.public_fe.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_fe.id
}

resource "aws_route" "private_ngw_fe" {
  route_table_id         = aws_route_table.private_fe.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw_fe.id
}
