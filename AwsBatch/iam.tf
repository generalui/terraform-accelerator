#######################################################################
# batch_service_role
#######################################################################
resource "aws_iam_role" "batch_service_role" {
  name = "${module.this.id}-batch-service"

  lifecycle {
    create_before_destroy = true
  }

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "batch.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(module.this.tags, { Name = "${module.this.id}-batch-service" })
}

resource "aws_iam_role_policy_attachment" "batch_service_role_policy_attachment" {
  role       = aws_iam_role.batch_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
}

#######################################################################
# batch_execution_role
#######################################################################
resource "aws_iam_role" "batch_execution_role" {
  name = "${module.this.id}-batch-execution"

  lifecycle { create_before_destroy = true }

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = { Service = "batch.amazonaws.com" }
    }]
  })

  tags = merge(module.this.tags, { Name = "${module.this.id}-batch-execution" })
}

resource "aws_iam_role_policy_attachment" "batch_execution_role_policy_attachment" {
  role       = aws_iam_role.batch_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

#######################################################################
# batch_instance_role - is for ECS
#######################################################################
resource "aws_iam_instance_profile" "batch_instance_profile" {
  name = "${module.this.id}-worker-instance-profile"
  role = aws_iam_role.batch_instance_role.name
}

resource "aws_iam_role" "batch_instance_role" {
  name = "${module.this.id}-worker-instance"

  lifecycle {
    create_before_destroy = true
  }

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(module.this.tags, { Name = "${module.this.id}-worker-instance" })
}

resource "aws_iam_role_policy_attachment" "ecr_access" {
  role       = aws_iam_role.batch_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "batch_instance_role_ec2_container_policy_attachement" {
  role       = aws_iam_role.batch_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

#################
# Batch Logging #
#################
data "aws_iam_policy_document" "logging" {
  statement {
    effect    = "Allow"
    actions   = ["logs:CreateLogStream"]
    resources = ["${local.event_log_group_arn}:*"]

    principals {
      type = "Service"
      identifiers = [
        "events.amazonaws.com",
        "delivery.logs.amazonaws.com"
      ]
    }
  }
  statement {
    effect    = "Allow"
    actions   = ["logs:PutLogEvents"]
    resources = ["${local.event_log_group_arn}:*:*"]

    principals {
      type = "Service"
      identifiers = [
        "events.amazonaws.com",
        "delivery.logs.amazonaws.com"
      ]
    }

    condition {
      test     = "ArnEquals"
      values   = [aws_cloudwatch_event_rule.batch.arn]
      variable = "aws:SourceArn"
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "batch_logging" {
  policy_document = data.aws_iam_policy_document.logging.json
  policy_name     = "${module.this.id}-batch-logging"
}
