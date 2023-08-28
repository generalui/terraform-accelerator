resource "aws_security_group" "ephemeral_api" {
  name        = "${var.environment_name}-ephemeral-api"
  description = "Ephemeral ports for ${var.name_api}"
  vpc_id      = aws_vpc.api.id

  ingress {
    from_port   = 31000
    to_port     = 61000
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    App  = var.name_api
    Name = "security-group-ephemeral"
  }
}

resource "aws_security_group" "https_api" {
  name        = "${var.environment_name}-https-api"
  description = "HTTPS traffic for ${var.name_api}"
  vpc_id      = aws_vpc.api.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    App  = var.name_api
    Name = "security-group-https"
  }
}

resource "aws_security_group" "egress_all_api" {
  name        = "${var.environment_name}-egress-all-api"
  description = "Allow all outbound traffic for ${var.name_api}"
  vpc_id      = aws_vpc.api.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    App  = var.name_api
    Name = "security-group-egress-all"
  }
}

resource "aws_security_group" "service_api" {
  name   = "${var.environment_name}-service-api"
  vpc_id = aws_vpc.api.id

  ingress {
    from_port   = 4000
    to_port     = 4000
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
    App  = var.name_api
    Name = "security-group-service"
  }
}


resource "aws_security_group" "db" {
  name        = "${var.environment_name}-db"
  description = "Security group for database"
  vpc_id      = aws_vpc.api.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.service_api.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "security-group-db"
  }
}
