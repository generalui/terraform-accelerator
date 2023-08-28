resource "aws_subnet" "public_fe" {
  vpc_id     = aws_vpc.fe.id
  cidr_block = "10.0.7.0/24"

  tags = {
    App  = var.name_fe
    Name = "subnet-public"
  }
}

resource "aws_subnet" "private_fe" {
  vpc_id     = aws_vpc.fe.id
  cidr_block = "10.0.8.0/24"

  tags = {
    App  = var.name_fe
    Name = "subnet-private"
  }
}
