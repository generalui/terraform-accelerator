# Creates IAM Role which is assumed by the Container Instances (aka EC2 Instances)
resource "aws_iam_role" "ec2_instance_role" {
  count              = module.this.enabled && local.is_ec2_launch_type ? 1 : 0
  name               = "${module.this.id}-ec2-instance-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_instance_role_policy[0].json
  tags               = merge(module.this.tags, { Name = "${module.this.id}-ec2-instance-role" })
}

resource "aws_iam_role_policy_attachment" "ec2_instance_role_policy" {
  count      = module.this.enabled && local.is_ec2_launch_type ? 1 : 0
  role       = aws_iam_role.ec2_instance_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

data "aws_iam_policy_document" "ec2_instance_role_policy" {
  count = module.this.enabled && local.is_ec2_launch_type ? 1 : 0
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com",
        "ecs.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_instance_profile" "ec2_instance_role_profile" {
  count = module.this.enabled && local.is_ec2_launch_type ? 1 : 0
  name  = module.this.id
  role  = aws_iam_role.ec2_instance_role[0].id
  tags  = merge(module.this.tags, { Name = "${module.this.id}" })
}
