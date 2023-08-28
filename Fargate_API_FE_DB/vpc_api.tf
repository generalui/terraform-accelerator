resource "aws_vpc" "api" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    App  = var.name_api
    Name = "vpc"
  }
}

resource "aws_route_table" "public_api" {
  vpc_id = aws_vpc.api.id

  tags = {
    App  = var.name_api
    Name = "route-table-public"
  }
}

resource "aws_route_table" "private_api" {
  vpc_id = aws_vpc.api.id

  tags = {
    App  = var.name_api
    Name = "route-table-private"
  }
}

resource "aws_route_table_association" "public_subnet_api" {
  subnet_id      = aws_subnet.public_api.id
  route_table_id = aws_route_table.public_api.id
}

resource "aws_route_table_association" "public_subnet_db_a" {
  subnet_id      = aws_subnet.db_a.id
  route_table_id = aws_route_table.public_api.id
}

resource "aws_route_table_association" "public_subnet_db_b" {
  subnet_id      = aws_subnet.db_b.id
  route_table_id = aws_route_table.public_api.id
}

resource "aws_route_table_association" "private_subnet_api" {
  subnet_id      = aws_subnet.private_api.id
  route_table_id = aws_route_table.private_api.id
}

resource "aws_eip" "nat_ip_api" {
  depends_on = [aws_internet_gateway.igw_api]
  domain = "vpc"
}

resource "aws_internet_gateway" "igw_api" {
  vpc_id = aws_vpc.api.id

  tags = {
    App  = var.name_api
    Name = "igw"
  }
}

resource "aws_nat_gateway" "ngw_api" {
  subnet_id     = aws_subnet.public_api.id
  allocation_id = aws_eip.nat_ip_api.id

  tags = {
    App  = var.name_api
    Name = "ngw"
  }
}

resource "aws_route" "public_igw_api" {
  route_table_id         = aws_route_table.public_api.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_api.id
}

resource "aws_route" "private_ngw_api" {
  route_table_id         = aws_route_table.private_api.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw_api.id
}
