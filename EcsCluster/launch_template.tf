# Get most recent AMI for an ECS-optimized Amazon Linux 2 instance
data "aws_ami" "amazon_linux_2" {
  count       = module.this.enabled && local.is_ec2_launch_type ? 1 : 0
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }
}


# Launch template for all EC2 instances that are part of the ECS cluster
resource "aws_launch_template" "ecs_ec2" {
  count                  = module.this.enabled && local.is_ec2_launch_type ? 1 : 0
  name                   = module.this.id
  image_id               = data.aws_ami.amazon_linux_2[0].id
  instance_type          = var.ec2_instance_type
  user_data              = base64encode(templatefile("${path.module}/user_data/user_data.sh", { ecs_cluster_name = "${aws_ecs_cluster.default[0].name}" }))
  update_default_version = var.launch_template_update_default_version
  vpc_security_group_ids = [aws_security_group.ec2[0].id]

  iam_instance_profile { arn = aws_iam_instance_profile.ec2_instance_role_profile[0].arn }

  monitoring { enabled = true }
  tags = merge(module.this.tags, { Name = "${module.this.id}" })
}
