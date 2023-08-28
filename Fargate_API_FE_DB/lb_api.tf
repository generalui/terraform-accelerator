resource "aws_lb" "api" {
  name               = "lb-api"
  load_balancer_type = "application"

  subnets = [
    aws_subnet.public_api.id,
    aws_subnet.private_api.id
  ]

  security_groups = [
    aws_security_group.ephemeral_api.id,
    aws_security_group.https_api.id,
    aws_security_group.egress_all_api.id
  ]

  tags = {
    App  = var.name_api
    Name = "lb"
  }
}

resource "aws_lb_target_group" "api" {
  port        = "4000"
  protocol    = "HTTP"
  vpc_id      = aws_vpc.api.id
  target_type = "ip"

  health_check {
    enabled             = true
    path                = "/healthcheck"
    matcher             = "200"
    interval            = 30
    unhealthy_threshold = 10
    timeout             = 25
  }

  tags = {
    Api  = var.name_api
    Name = "lb-target-group"
  }

  depends_on = [aws_lb.api]
}

resource "aws_lb_listener" "http_api" {
  load_balancer_arn = aws_lb.api.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener_certificate" "listener_cert_api" {
  listener_arn    = aws_lb_listener.https_api.arn
  certificate_arn = var.cert_arn_api
}

resource "aws_lb_listener" "https_api" {
  certificate_arn   = var.cert_arn_api
  load_balancer_arn = aws_lb.api.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"

  default_action {
    target_group_arn = aws_lb_target_group.api.arn
    type             = "forward"
  }
}
