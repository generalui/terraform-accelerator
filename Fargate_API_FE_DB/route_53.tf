resource "aws_route53_record" "www_api" {
  name    = var.domain_api
  type    = "A"
  zone_id = var.zone_id

  alias {
    name                   = aws_lb.api.dns_name
    zone_id                = aws_lb.api.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www_fe" {
  name    = var.domain_fe
  type    = "A"
  zone_id = var.zone_id_fe

  alias {
    name                   = aws_lb.fe.dns_name
    zone_id                = aws_lb.fe.zone_id
    evaluate_target_health = true
  }
}
