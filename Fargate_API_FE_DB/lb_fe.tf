resource "aws_lb" "fe" {
  name = "lb-fe"

  subnets = [
    aws_subnet.public_fe.id,
    aws_subnet.private_fe.id
  ]

  security_groups = [
    aws_security_group.ephemeral_fe.id,
    aws_security_group.https_fe.id,
    aws_security_group.egress_all_fe.id
  ]

  tags = {
    App  = var.name_fe
    Name = "lb"
  }
}

resource "aws_lb_target_group" "fe" {
  port        = "3000"
  protocol    = "HTTP"
  vpc_id      = aws_vpc.fe.id
  target_type = "ip"

  health_check {
    enabled             = true
    path                = "/"
    matcher             = "200"
    interval            = 30
    unhealthy_threshold = 10
    timeout             = 25
  }

  tags = {
    App  = var.name_fe
    Name = "lb-target-group"
  }

  depends_on = [aws_lb.fe]
}

resource "aws_lb_listener" "http_fe" {
  load_balancer_arn = aws_lb.fe.arn
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

resource "aws_lb_listener_certificate" "listener_cert_fe" {
  listener_arn    = aws_lb_listener.https_fe.arn
  certificate_arn = var.cert_arn_fe
}

resource "aws_lb_listener" "https_fe" {
  certificate_arn   = var.cert_arn_fe
  load_balancer_arn = aws_lb.fe.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"

  default_action {
    target_group_arn = aws_lb_target_group.fe.arn
    type             = "forward"
  }
}
