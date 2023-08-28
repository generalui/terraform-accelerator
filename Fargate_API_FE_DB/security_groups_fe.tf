resource "aws_security_group" "ephemeral_fe" {
  name        = "${var.environment_name}-ephemeral-fe"
  description = "Ephemeral ports for ${var.name_fe}"
  vpc_id      = aws_vpc.fe.id

  ingress {
    from_port   = 31000
    to_port     = 61000
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    App  = var.name_fe
    Name = "security-group-ephemeral"
  }
}

resource "aws_security_group" "https_fe" {
  name        = "${var.environment_name}-https-fe"
  description = "HTTPS traffic for ${var.name_fe}"
  vpc_id      = aws_vpc.fe.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    App  = var.name_fe
    Name = "security-group-https"
  }
}

resource "aws_security_group" "egress_all_fe" {
  name        = "${var.environment_name}-egress-all-fe"
  description = "Allow all outbound traffic for ${var.name_fe}"
  vpc_id      = aws_vpc.fe.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    App  = var.name_fe
    Name = "security-group-egress-all"
  }
}

resource "aws_security_group" "service_fe" {
  name   = "${var.environment_name}-service-fe"
  vpc_id = aws_vpc.fe.id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    App  = var.name_fe
    Name = "security-group-service"
  }
}
