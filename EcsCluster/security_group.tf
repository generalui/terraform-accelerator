# SG for EC2 instances

resource "aws_security_group" "ec2" {
  count       = module.this.enabled && local.is_ec2_launch_type ? 1 : 0
  name        = "${module.this.id}-ec2"
  description = "Security group for EC2 instances in ECS cluster"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow ingress traffic from ALB on HTTP on ephemeral ports"
    from_port       = 1024
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [var.alb_security_group]
  }

  #   ingress {
  #     description     = "Allow SSH ingress traffic from bastion host"
  #     from_port       = 22
  #     to_port         = 22
  #     protocol        = "tcp"
  #     security_groups = [aws_security_group.bastion_host.id]
  #   }

  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(module.this.tags, { Name = "${module.this.id}-ec2" })
}
